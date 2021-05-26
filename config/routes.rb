Rails.application.routes.draw do
  
  use_doorkeeper
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

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

 namespace :api do
    resources :tweets
      get ':fecha1/:fecha2', to: 'tweets#date_filter'
      post 'create', to: "tweets#create"    
      resources :news, controller: :tweets, only: :index
  end

  # namespace :api do
  #   get ':fecha1/:fecha2', to: 'tweets#date_filter'
  #   resources :news, controller: :tweets, only: :index
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
