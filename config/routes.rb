Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#welcome'
  get 'home', to: 'pages#home'
  get 'settings', to: 'pages#settings'
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :conversations, only: [:create, :index, :show] do
    resources :milts, only: :create
  end
  resources :participations, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
