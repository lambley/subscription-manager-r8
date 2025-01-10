Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  root "home#index"
  resources :subscriptions, only: %i[ index show ]
end
