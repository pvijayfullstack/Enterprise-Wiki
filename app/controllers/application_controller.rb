class ApplicationController < ActionController::Base
  REALM = "Enterprise Wiki Software"
  
  protect_from_forgery
  
  protected
    def authenticate
      authenticate_or_request_with_http_digest(REALM) do |username|
        # TODO
      end
    end
end
