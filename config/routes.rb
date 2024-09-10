Rails.application.routes.draw do
  root "homes#index"
  get "/home", to: "homes#home"

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :scribbles, except: :show
  get "export-data", to: "scribbles#export_data", as: :export_data
end
