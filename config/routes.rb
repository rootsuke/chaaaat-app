Rails.application.routes.draw do
  root to: "rooms#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :rooms, only: %i[show]
end
