Rails.application.routes.draw do
  resources :posts, except: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  root 'application#index'
=======
  root "posts#index"
>>>>>>> 68bf5ccd1bfd508946d5ca36df9deb90f9b5f1b7
end
