class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  def error (code)
    render "error/#{code}", :status => code, :layout => false
  end
  
end
