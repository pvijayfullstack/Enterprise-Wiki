EnterpriseWiki::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  themes_for_rails
  
  match '/'    => redirect('/Home')
  match 'edit' => redirect('/Home/edit')
  
  match '*path/edit' => 'page#edit', :via => :get
  match '*path'      => 'page#save', :via => [:put, :post]
  match '*path'      => 'page#show', :via => :get
end
