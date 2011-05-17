HikingStats::Application.routes.draw do
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'reset_password' => 'users#password', :as => :password
	match 'search' => 'hikes#search', :as => :search
	match 'advanced_search' => 'hikes#advanced_search', :as => :advanced_search

  resources :user_sessions
  resources :users do
		resources :hikes
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

  match '/' => 'static#index', :as => :root
  match '/:controller(/:action(/:id))'
  match '*path' => 'static#index'
end
