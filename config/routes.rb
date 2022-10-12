require 'resque/server'
Rails.application.routes.draw do

  
  resources :tweetlikes
  # resources :tweets
  resources :comments
  root "welcome#index"
  match 'sign_in'=>'users#sign_in', via: [:get, :post]
  post 'login'=>'users#user_login'
  resources :users do
    resources :tweets do      
    end
    member do
        get 'follow_user'
        get 'unfollow'
        get 'new_topic'
        post 'create_topic'
        get 'topic'
    end
  end

  get 'twitter'=>'home#index'
  get 'logout'=>'home#logout'


  get 'follow_topic/:id', to: 'tweets#follow_topic', as: :follow_topic
  get 'show_modal/:id', to: 'tweets#show_modal', as: :show_modal
  get 'user_comment/:id', to: 'comments#user_comment', as: :user_comment
  get 'user_like/:id', to: 'tweetlikes#user_like', as: :user_like
  get 'user_dislike/:id', to: 'tweetlikes#user_dislike', as: :user_dislike
  post 'user_create_comment/:id', to: 'comments#user_create_comment', as: :user_create_comment
  # get 'comment/:id', to: 'tweets#comment', as: :comment

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Resque::Server.new, at: '/jobs'
  
end
