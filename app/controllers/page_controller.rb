class PageController < ApplicationController
  def show
    redirect_to "/#{params[:path]}/edit" unless @page = get_page
  end
  
  def edit
    if p = get_page
      @page = p.clone
      @page.revision += 1
    else
      @page = Page.new(:path => params[:path], :editor => 'somebody', :revision => 1)
    end
  end
  
  def save
    @page = Page.new(params[:page])
    if @page.save
      redirect_to "/#{@page.path}"
    else
      render :edit
    end
  end
  
  private
    def get_page
      Page.find_latest_by_path(params[:path])
    end
end
