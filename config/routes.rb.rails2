ActionController::Routing::Routes.draw do |map|
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.password 'reset_password', :controller => 'users', :action => 'password'

  map.resources :user_sessions
  map.resources :users, :as => :with, :has_many => [:hikes, :comments]
  map.resources :hikes, :has_many => [:photos, :comments], :collection => [:search]
	map.resources :map_layers
	map.resources :routes
	map.resources :photos
	map.resources :forecasts
	map.resources :comments

	map.root :controller => 'static'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
	map.connect '*path', :controller => 'static', :action => 'index'
end
