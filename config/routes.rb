Rails.application.routes.draw do
  root "homes#index"

  devise_for :users
  
  resources :scribbles, except: :show
end
