Rails.application.routes.draw do
  get 'paystack/callback'
  get 'paystack/webhook'
  devise_for :users
  root to: "susus#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "susus/:id/disburse", to: "susus#disburse", as: :disburse
  post "susus/:id/create-members", to: "members#create_members", as: :create_members

  resources :susus, except: [:edit, :destroy, :update] do
    resources :messages, only: %i[index create]
    resources :deposits, only: %i[new create]
    resources :members, only: %i[index new create]
    resources :users, only: %i[index]

  end
  resources :members, only: %i[update]
  resources :deposits, only: %i[show]


  # Defines the root path route ("/")
  # root "posts#index"

post "susus/:id/accept_invite", to: "susus#accept_invite", as: :accept_invite
post "susus/:id/decline_invite", to: "members#declined", as: :decline_invite

post '/paystack/callback', to: 'paystack#callback'
post '/paystack/webhook', to: 'paystack#webhook'
end
