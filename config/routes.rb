Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "edit_budget", to: "users#edit_budget"
  patch "update_budget", to: "users#update_budget"

  root "home#index"
  resources :subscriptions
end
