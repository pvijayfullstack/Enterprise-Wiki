require 'uri'

class PageController < ApplicationController
  before_filter :escape_path
  before_filter :authenticate_user!, :except => :show
  before_filter :authorize_edit, :only => [:edit, :save]
  
  def show
    redirect_to "/#{@path}/edit" unless @page = get_page
  end
  
  def edit
    if p = get_page
      @page = p.clone
      @page.editor = current_user
      @page.revision += 1
    else
      @page = Page.new(:path => @path, :editor => current_user, :revision => 1)
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
      Page.find_latest_by_path(@path)
    end
    
    def escape_path
      @path = URI::escape(params[:path])
    end
    
    def render_unauthorized
      render :unauthorized, :layout => 'error'
    end
    
    def authorize_edit
      render_unauthorized unless current_user.can_edit? @path
    end
end
