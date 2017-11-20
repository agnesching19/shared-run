Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}
  root to: 'pages#home'

  resources :events
  resources :runs
end
