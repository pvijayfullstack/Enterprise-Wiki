require 'uri'

class PageController < ApplicationController
  before_filter :authenticate, :except => :show
  before_filter :escape_path
  
  def show
    redirect_to "/#{params[:path]}/edit" unless @page = get_page
  end
  
  def edit
    if p = get_page
      @page = p.clone
      @page.editor = current_user
      @page.revision += 1
    else
      @page = Page.new(:path => params[:path], :editor => current_user, :revision => 1)
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
    def get_page
      Page.find_latest_by_path(params[:path])
    end
    
    def escape_path
      params[:path] = URI::escape(params[:path])
    end
end
