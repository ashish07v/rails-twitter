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
    end
  end

  get 'twitter'=>'home#index'
  get 'logout'=>'home#logout'


  get 'show_modal/:id', to: 'tweets#show_modal', as: :show_modal
  get 'user_comment/:id', to: 'comments#user_comment', as: :user_comment
  post 'user_create_comment/:id', to: 'comments#user_create_comment', as: :user_create_comment
  # get 'comment/:id', to: 'tweets#comment', as: :comment

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  
end
