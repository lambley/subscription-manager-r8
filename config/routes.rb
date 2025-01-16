Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  root "home#index"
  resources :subscriptions
end
