Rails.application.routes.draw do
  root to: "rooms#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :rooms do
    get :members, on: :member
  end
  resources :users, param: :user_id, path: "/", only: %i(show) do
    get :search, on: :collection
    get :friends, on: :member
  end
  resources :friend_requests, only: %i(create destroy update)
end
