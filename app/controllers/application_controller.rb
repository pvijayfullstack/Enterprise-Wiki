class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  def error (code)
    render "error/#{code}", :status => code, :layout => false
  end
  
  def after_sign_in_path_for (resource)
    stored_location_for(resource) || session[:last_page_path] || root_path
  end
  
private
  def after_sign_out_path_for (resource)
    # FIXME this is not working (not invoked?)
    session[:last_page_path] || root_path
  end
  
end
