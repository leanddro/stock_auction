Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :categories, only: %i(index new create update show) do
    post 'toggle', on: :member
  end
end
