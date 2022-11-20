Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  get 'unban', to: 'unban#index'
  get 'about', to: 'pages#about'
  get 'milo', to: 'milo#index'
  get 'contact-me', to:'contacts#new', as: 'new_contact'
  resources :contacts, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
