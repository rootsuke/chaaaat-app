Rails.application.routes.draw do
  root to: "rooms#show"
  devise_for :users
end
