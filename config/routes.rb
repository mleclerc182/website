Rails.application.routes.draw do
  get 'comments/create'
  resources :posts do
    post 'comments', to: 'comments#create'
  end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root 'pages#home'
  get 'unban', to: 'unban#index'
  get 'about', to: 'pages#about'
  get 'milo', to: 'milo#index'
  get 'test', to: 'pages#test'
  get 'contact-me', to:'contacts#new', as: 'new_contact'
  resources :contacts, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
