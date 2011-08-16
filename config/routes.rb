EnterpriseWiki::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  themes_for_rails
  
  root :to => "home#index"
  
  match ':user(/*path)' => 'user#show', :user => /~\w+/
  
end
