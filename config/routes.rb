Rails.application.routes.draw do
  get 'users/show'

  devise_for :users
  resources :users, only: :show

  root 'tweets#index'
  resources :tweets
end
