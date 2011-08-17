EnterpriseWiki::Application.routes.draw do
  devise_for :users
  themes_for_rails
  
  root :to => redirect('/Home')
  
  match '*path/edit' => 'page#edit', :via => :get
  match '*path'      => 'page#save', :via => [:put, :post]
  match '*path'      => 'page#show', :via => :get
end
