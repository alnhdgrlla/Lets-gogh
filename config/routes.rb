Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bookings, only: [:index]
  resources :supplies do
    resources :bookings, only: [:show, :new, :create]
    resources :reviews, only: [:create]
  end
  get 'my_supplies', to: 'supplies#my_supplies', as: :my_supplies
end
