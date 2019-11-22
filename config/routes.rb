Rails.application.routes.draw do
  resources :comments
  devise_for :users, path: '', path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout'}

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
  end

  # resources :messages
  resources :conversations do
  	resources :messages
  end

  match 'users/:id' => 'users#show', via: :get, as: 'users'
  match 'users/:id/edit' => 'users#edit', via: :get, as: 'edit_user'
  match 'users/:id' => 'users#update', via: :put 
 # match 'users' => 'users#show', via: :get, as: 'users'

  resources :users
  resources :posts, except: :index do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
end
