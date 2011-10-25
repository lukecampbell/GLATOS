Glatos::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :users, :only => [:index, :destroy, :update]
  resources :reports, :only => [:index, :new, :create, :destroy]
  resources :explore, :only => [:index]
  resources :deployments, :only => [:index, :destroy]
  resources :studies, :only => [:index] do
    resources :deployments, :only => [:index, :destroy]
  end

end
