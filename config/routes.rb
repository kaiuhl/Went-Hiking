HikingStats::Application.routes.draw do
  resources :messages

  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'reset_password' => 'users#password', :as => :password
	match 'search' => 'trips#search', :as => :search
	match 'advanced_search' => 'trips#advanced_search', :as => :advanced_search
	match 'map' => 'routes#new'
	match 'about' => 'static#about'
	match 'privacy_policy' => 'static#privacy_policy'
	match 'donate' => 'static#donate'

  resources :user_sessions
  resources :users do
		resources :hikes, controller: 'trips', as: 'trips'
		resources :forecasts
	end
  resources :hikes, as: 'trips', controller: 'trips' do
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
