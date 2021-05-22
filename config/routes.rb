Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :tweets do
    resources :likes
    member do 
      post 'retweet'
    end
  end
  root to: 'tweets#index'

  resources :users, :only => :show do
    member do
      post 'follow'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
