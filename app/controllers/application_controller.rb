class ApplicationController < ActionController::Base
  REALM = "Enterprise Wiki Software"
  
  protect_from_forgery
  
  protected
    def authenticate
      authenticate_or_request_with_http_digest(REALM) do |username|
        @current_user.digest if @current_user = User.find_by_name(username)
      end
    end
    
    def current_user
      @current_user
    end
end
