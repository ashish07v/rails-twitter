Rails.application.routes.draw do

  
  # resources :tweets
  root "welcome#index"
  match 'sign_in'=>'users#sign_in', via: [:get, :post]
  post 'login'=>'users#user_login'
  resources :users do
    resources :tweets do
      resources :comments
    end
    member do
        get 'follow_user'
        get 'unfollow'
    end
  end

  get 'twitter'=>'home#index'
  get 'logout'=>'home#logout'


  get 'show_modal/:id', to: 'tweets#show_modal', as: :show_modal
  get 'show_comment/:id', to: 'comments#show_comment', as: :show_comment
  # get 'comment/:id', to: 'tweets#comment', as: :comment

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  
end
