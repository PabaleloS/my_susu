Rails.application.routes.draw do
  devise_for :users
  root to: "susus#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :susus, except: [:edit, :destroy, :update] do
    resources :messages, only: %i[index create]
    resources :deposits, only: %i[create]
    resources :members, only: %i[index new create]
    resources :users, only: %i[index]

  end
  resources :members, only: %i[update]
  resources :deposits, only: %i[show]
  post "susus/:id/disburse", to: "susus#disburse"

  # Defines the root path route ("/")
  # root "posts#index"
end
