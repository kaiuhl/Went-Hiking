HikingStats::Application.routes.draw do
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'reset_password' => 'users#password', :as => :password
	match 'search' => 'hikes#search', :as => :search
	match 'advanced_search' => 'hikes#advanced_search', :as => :advanced_search
	match 'map' => 'routes#new'
	match 'about' => 'static#about'
	match 'privacy_policy' => 'static#privacy_policy'
	match 'donate' => 'static#donate'

  resources :user_sessions
  resources :users do
		resources :hikes
		resources :forecasts
	end
  resources :hikes, :collection => :search do
		resources :comments
		resources :photos
		resources :hearts
	end
  resources :map_layers
  resources :routes
  resources :photos
  resources :forecasts
  resources :comments
  resources :notifications

	# legacy route support
	match '/with(/*path)' => redirect{|params| "/users/#{params[:path]}".chomp("/") }
  match '/:controller(/:action(/:id))'
	root :to => 'static#home'
end
