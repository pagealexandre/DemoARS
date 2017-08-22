Rails.application.routes.draw do
  	devise_for :users
  	resources :reservations
  	post 'auth' => 'authentication#authenticate_user'
  	get 'sign_in', to: 'authentication#index'
  	get 'auth/:provider/callback', to: 'authentication#create'
  	get 'logout', 				 to: 'authentication#destroy'
  	root to: 'authentication#index'
end
