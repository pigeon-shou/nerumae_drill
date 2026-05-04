Rails.application.routes.draw do
  devise_for :users
  root "learnings#index"
  resources :learnings, only: [:index, :new, :create]
end
