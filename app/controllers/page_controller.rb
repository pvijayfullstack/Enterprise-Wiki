require 'uri'
require 'digest/md5'
require 'fileutils'

class PageController < ApplicationController
  before_filter :escape_path
  before_filter :authenticate_user!, :except => :view
  before_filter :authorize_save, :only => :save
  
  def view
    if edit?
      try_edit
    elsif upload?
      try_upload
    else
      try_show
    end
  end
  
  def save
    if upload_file?
      save_file
    else
      save_page
    end
  end
  
private
  def query_params
    params.select {|k,v| not %w(controller action path).include?(k) }
  end
  
  def query_pairs
    query_params.collect {|k,v| "#{k}=#{v}" }
  end
  
  def query_string
    if query_params.empty?
      ""
    else
      "?" + query_pairs.join("&")
    end
  end
  
  def slugified_path
    PageHelper.slugify params[:path]
  end
  
  def path_slugified?
    slugified_path == params[:path]
  end
  
  def escaped_path
    URI.escape slugified_path
  end
  
  def escaped_path_with_query
    "/" + escaped_path + query_string
  end
  
  def escape_path
    if not path_slugified?
      redirect_to escaped_path_with_query
    else
      @path = escaped_path
    end
  end
  
  def can_edit_path?
    user_signed_in? and current_user.can_edit? @path
  end
  
  def can_upload_path?
    user_signed_in? and current_user.can_upload? @path
  end
  
  def upload_file?
    params[:commit] == "Upload"
  end
  
  def authorize_save
    if upload_file?
      error 422 unless can_upload_path?
    else
      error 422 unless can_edit_path?
    end
  end
  
  def get_page
    Page.find_latest_by_path(@path)
  end
  
  def can_show_path?
    user_signed_in? and current_user.can_show? @path
  end
  
  def can_show_page?
    if can_edit_path?         # bypass - he can view by editing otherwise
      true
    elsif @page.is_private?   # check prefix rules
      can_show_path?
    elsif @page.is_protected? # allow signed in users
      user_signed_in?
    else                      # otherwise, public to all
      true
    end
  end
  
  def try_show
    if @page = get_page
      show
    else
      error 404
    end
  end
  
  def show
    if can_show_page?
      if @page.plain?
        render :text => @page.body, :content_type => 'text/plain'
        #elsif @page.file?
        # TODO send file here
      else
        render :show
      end
    else
      error 401
    end
  end
  
  def edit?
    params[:edit] or params[:do] == "edit"
  end
  
  def try_edit
    if can_edit_path?
      edit
    else
      error 401
    end
  end
  
  def edit
    @page = build_page
    render :edit
  end
  
  def build_revision
    if p = get_page
      p.revision + 1
    else
      1
    end
  end
  
  def build_page
    p = Page.new(params[:page])
    p.path = @path
    p.editor = current_user
    p.revision = build_revision
    p
  end
  
  def save_page
    @page = build_page
    if @page.save
      redirect_to @page.to_s
    else
      render :edit
    end
  end
  
  def upload?
    params[:upload] or params[:do] == "upload"
  end
  
  def try_upload
    if can_upload_path?
      upload
    else
      error 401
    end
  end
  
  def upload
    @page = build_file
    render :upload
  end
  
  def build_file
    p = build_page
    p.markup = Markup.find_by_title("Uploaded File")
    p
  end
  
  # Currently this action is not transactional.
  # It means that it is supposed both the file system operations
  # and the database operations are all executed successfully.
  # Handle database transaction is easy but file system transaction
  # is hard, especially working together with the database.
  def save_file
    if @the_file = params[:somefile]
      base = "/data/Enterprise-Wiki"  # TODO move this constant to some other place
      name = current_user.name
      path = "#{base}/#{name[0..1]}/#{name[2..3]}/#{name}"
      
      new_filename = Digest::MD5.hexdigest(@the_file.original_filename + Time.now.to_s)
      new_filepath = "#{path}/#{new_filename}"
      tmp_filepath = @the_file.tempfile.path
      
      FileUtils.mkpath path
      FileUtils.cp tmp_filepath, new_filepath
      
      @page = build_file
      @page.body = new_filepath
      if @page.save
        redirect_to @page.to_s
      else
        render :upload
      end
    else
      @page = build_file
      render :upload
    end
  end
  
end
