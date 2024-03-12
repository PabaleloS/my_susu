Rails.application.routes.draw do
  devise_for :users
  root to: "susu#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :susu, except: [:edit, :destroy, :update] do
    resources :messages, only: %i[index create]
    resources :transaction, only: %i[new create]

  end
  resources :members, only: %i[update]
  resources :transaction, only: %i[show]
  post "susu/:id/disburse", to: "susus#disburse"

  # Defines the root path route ("/")
  # root "posts#index"
end
