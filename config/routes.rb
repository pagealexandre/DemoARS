Rails.application.routes.draw do
  devise_for :users
  resources :reservations
  post 'auth' => 'authentication#authenticate_user'
end
