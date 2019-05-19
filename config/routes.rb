Rails.application.routes.draw do
  root to: "rooms#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :rooms, param: :room_name, only: %i[show create] do
    get :members, on: :member
  end
  resources :users, param: :user_name, only: %i(show) do
    get :search, on: :collection
  end
end
