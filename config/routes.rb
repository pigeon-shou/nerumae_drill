Rails.application.routes.draw do
  get 'linebot/callback'
  devise_for :users
  root "learnings#index"
  resources :learnings, only: [:index, :new, :create, :show, :edit, :destroy, :update]
  resources :users, only: [:show]
  resources :reviews, only: [:update]
  post '/callback', to: 'linebot#callback'
end
