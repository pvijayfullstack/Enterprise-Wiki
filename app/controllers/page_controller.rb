require 'uri'

class PageController < ApplicationController
  before_filter :escape_path
  before_filter :authorize_save, :only => :save
  
  def view
    if edit?
      try_edit
    else
      error 404 unless @page = get_page
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
    @path = URI::escape(params[:path])
  end
  
  def can_edit_path?
    current_user.can_edit? @path
  end
  
  def authorize_save
    error 422 unless can_edit_path?
  end
  
  def get_page
    Page.find_latest_by_path(@path)
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
