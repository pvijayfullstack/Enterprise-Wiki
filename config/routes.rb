EnterpriseWiki::Application.routes.draw do
  match 'site/password' => 'site#edit_password', :via => :get
  match 'site/password' => 'site#save_password', :via => [:put, :post]
  
  match 'site/users/new' => 'site#new_users',    :via => :get
  match 'site/users/new' => 'site#create_users', :via => [:put, :post]
  
  devise_for :users
  themes_for_rails
  
  root :to => redirect('/home')
  
  # do not start with "admin", 
  # or do not start with "admin/" 
  # (which may be "admin123")
  page_constraints = { :path => /(?!(admin|themes|users|site)).*|(admin|themes|users|site)(?!\/).+/ }
  
  match '*path' => 'page#view', :constraints => page_constraints, :via => :get
  match '*path' => 'page#save', :constraints => page_constraints, :via => [:put, :post]
end
