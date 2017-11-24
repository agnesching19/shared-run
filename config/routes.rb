Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" } do
    get 'logout' => 'devise/sessions#destroy'
  end

  as :user do
    get 'users/profile', :to => 'devise/registrations#edit', :as => :user_root
  end

  resources :events
  resources :runs do
    resources :invites, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
    resources :messages, only: [:index, :new, :create]
  end

  resources :messages, only: [:show, :edit, :update, :destroy]

  resources :invites, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]

  root to: "pages#home"
  get "users/:id/dashboard", to: "users#dashboard", as: "dashboard"

end
