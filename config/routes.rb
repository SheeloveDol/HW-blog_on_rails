Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do 
    delete :destroy, on: :collection
  end
  
  root 'posts#index'
  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  
end
