Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :users, only:[] do
    resources :links
    resources :images
  end
end
