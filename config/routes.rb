EnterpriseWiki::Application.routes.draw do
  devise_for :users
  themes_for_rails
  
  root :to => redirect('/Home')
  
  # do not start with "admin", 
  # or do not start with "admin/" 
  # (which may be "admin123")
  page_constraints = { :path => /(?!admin).*|admin(?!\/).+/ }
  
  match '*path/edit' => 'page#edit', :constraints => page_constraints, :via => :get
  match '*path'      => 'page#save', :constraints => page_constraints, :via => :post
  match '*path'      => 'page#show', :constraints => page_constraints, :via => :get
end
