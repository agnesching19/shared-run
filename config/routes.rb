Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" } do
    get "logout" => "devise/sessions#destroy"

  end

  as :user do
    get "users/profile", to: "devise/registrations#edit", as: :user_root
    get "users/:id/preferences", to: "preferences#index", as: :preferences
    get "users/:id/preferences/new", to: "preferences#new", as: :new_preference
    post "users/:id/preferences", to: "preferences#create"
    get "users/:id/preferences/edit", to: "preferences#edit", as: :edit_preference
    patch "users/:id/preferences", to: "preferences#update"
  end

  resources :events

  resources :runs do
    resources :invites, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
    resources :messages, only: [:index, :create, :destroy]
    resources :bookings, only: [:index, :new, :create]
  end


  resources :invites, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]
  resources :messages, only: [:show]
  resources :bookings, only: [:destroy]

  root to: "pages#home"

  get "users/:id/dashboard", to: "users#dashboard", as: "dashboard"
  get "pages/about", to: "pages#about", as: "about"

end
