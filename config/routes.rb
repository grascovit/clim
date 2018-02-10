Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :clients, only: [] do
        resources :tasks, module: :clients
      end
      resources :users, only: :create do
        resources :clients, module: :users
        resources :tasks, only: :index, module: :users
      end
      resource :user_token, only: :create, controller: :user_token
    end
  end
end
