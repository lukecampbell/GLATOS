Glatos::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :users, :only => [:index, :destroy, :update]
  resources :reports, :only => [:index, :new, :create, :destroy]
  resources :explore, :only => [:index]

end
