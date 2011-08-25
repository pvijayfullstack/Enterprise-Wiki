EnterpriseWiki::Application.routes.draw do
  get "test/download"

  devise_for :users
  themes_for_rails
  
  root :to => redirect('/home')
  
  match '/test/download' => 'test#download'
  match '/test/upload'   => 'test#upload'
  
  # do not start with "admin", 
  # or do not start with "admin/" 
  # (which may be "admin123")
  page_constraints = { :path => /(?!(admin|themes|users|test)).*|(admin|themes|users|test)(?!\/).+/ }
  
  match '*path' => 'page#view', :constraints => page_constraints, :via => :get
  match '*path' => 'page#save', :constraints => page_constraints, :via => [:put, :post]
end
