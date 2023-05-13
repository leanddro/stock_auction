Rails.application.routes.draw do
  root 'pages#home'
  get 'users/profile/', to: 'users#profile', as: 'user_profile'

  devise_for :users
  resources :categories, only: %i(index new create update show) do
    post 'toggle', on: :member
  end

  resources :items, only: %i(index new create show)
  resources :batches, only: %i(index new create show) do
    patch 'approve', on: :member
    patch 'finish', on: :member
    patch 'cancel', on: :member
  end
end
