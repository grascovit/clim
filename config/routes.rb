Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      resource :user_token, only: :create, controller: :user_token
    end
  end
end
