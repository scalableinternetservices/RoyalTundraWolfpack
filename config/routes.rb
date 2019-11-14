Rails.application.routes.draw do
  resources :conversations
  resources :users
  resources :posts, except: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
end
