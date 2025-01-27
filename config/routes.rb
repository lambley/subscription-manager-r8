Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  get "edit_budget", to: "users#edit_budget"
  patch "update_budget", to: "users#update_budget"

  root "home#index"
  resources :subscriptions
end
