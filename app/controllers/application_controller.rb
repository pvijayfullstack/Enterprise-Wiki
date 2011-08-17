class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
    def authenticate
      authenticate_or_request_with_http_digest(User.realm) do |username|
        User.find_by_name(username).digest
      end
    end
end
