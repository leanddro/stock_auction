Rails.application.routes.draw do
  root 'pages#home'
  get 'lotes/:id', to: 'pages#batch_detail', as: 'batch_detail'

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
    post 'item/:item_id', on: :member, to: 'batches#add', as: 'add_item'
  end
  resources :bids, only: %i(create)
end
