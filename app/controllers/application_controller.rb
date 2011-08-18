class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
protected
  def error (code)
    render "error/#{code}", :status => code, :layout => false
  end
  
end
