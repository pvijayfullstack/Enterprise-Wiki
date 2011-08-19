require 'uri'

class PageController < ApplicationController
  before_filter :escape_path
  before_filter :authenticate_user!, :except => :view
  before_filter :authorize_save, :only => :save
  
  def view
    if edit?
      try_edit
    else
      try_show
    end
  end
  
  def save
    @page = Page.new(params[:page])
    if @page.save
      redirect_to @page.to_s
    else
      render :edit
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
  
  def authorize_save
    error 422 unless can_edit_path?
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
      render :show
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
    if p = get_page
      @page = p.new_revision(:editor => current_user)
    else
      @page = Page.new(:path => @path, :editor => current_user, :revision => 1)
    end
    render :edit
  end
  
end
