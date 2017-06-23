Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :products

  get '/cart' => 'cart#edit'
  get '/cart_link' => 'cart#cart_link'
  put '/update_cart' => 'cart#update'
end
