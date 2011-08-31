EnterpriseWiki::Application.routes.draw do
  devise_for :users
  themes_for_rails
  
  root :to => redirect('/home')
  
  # do not start with "admin", 
  # or do not start with "admin/" 
  # (which may be "admin123")
  page_constraints = { :path => /(?!(admin|themes|users)).*|(admin|themes|users)(?!\/).+/ }
  
  match '*path' => 'page#view', :constraints => page_constraints, :via => :get
  match '*path' => 'page#save', :constraints => page_constraints, :via => [:put, :post]
end
