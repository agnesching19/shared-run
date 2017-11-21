Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" } do
    get 'logout' => 'devise/sessions#destroy'
  end

  resources :events
  resources :runs do
    resources :invites, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :invites, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]

end
