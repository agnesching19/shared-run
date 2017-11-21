Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :events
  resources :runs do
    resources :invites, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :invites, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]

  # devise_scope :user do
    # delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    # get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  # end

end
