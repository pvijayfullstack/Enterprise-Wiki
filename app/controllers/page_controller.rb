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
  def escape_path
    replaced = PageHelper.replace_spaces_in params[:path]
    @path = URI.escape replaced
    if replaced != params[:path]
      redirect_to "/#{@path}" # TODO query string not considered
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
      if can_show_page?
        render :show
      else
        error 401
      end
    else
      error 404
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
      @page = p.clone
      @page.editor = current_user
      @page.revision += 1
    else
      @page = Page.new(:path => @path, :editor => current_user, :revision => 1)
    end
    render :edit
  end
  
end
