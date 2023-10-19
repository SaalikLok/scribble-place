Rails.application.routes.draw do
  root "homes#index"
  get "/home", to: "homes#index"

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :scribbles, except: :show do
    collection do
      post :index
    end
  end
end
