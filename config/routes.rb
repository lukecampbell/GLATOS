Glatos::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :users, :only => [:index, :destroy, :update]
  resources :reports
  resources :explore, :only => [:index]

end
