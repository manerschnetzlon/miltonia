Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#welcome'
  get 'home', to: 'pages#home'
  get 'insight', to: 'pages#insight'
  get 'settings', to: 'pages#settings'
  get 'add_received_milts', to: 'milts#add_received_milts'
  get 'add_sent_milts', to: 'milts#add_sent_milts'
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :conversations, only: [:create, :index, :show] do
    resources :milts, only: :create
  end
  resources :participations, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
