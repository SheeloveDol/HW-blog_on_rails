Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy] 
  
  root 'posts#index'
  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  
end
