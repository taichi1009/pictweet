Rails.application.routes.draw do
  get 'users/show'

  devise_for :users
  resources :users, only: :show

  root 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
  end
end
