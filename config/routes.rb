Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bookings, only: [:index, :show, :update]
  resources :supplies do
    resources :bookings, only: [:new, :create]
  end
  get 'my_supplies', to: 'supplies#my_supplies', as: :my_supplies
end
