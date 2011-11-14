Glatos::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :users, :only => [:index, :destroy, :update]
  resources :reports, :only => [:index, :new, :create, :destroy, :update] do
    get 'info', :on => :collection
  end

  resources :deployments, :only => [:index, :destroy]
  resources :studies, :only => [:index] do
    resources :deployments, :only => [:index, :destroy]
    resources :reports, :only => [:index, :destroy, :update]
  end

  match 'explore' => 'explore#index', :as => :explore, :via => :get
  match 'search' => 'search#index', :as => :search, :via => :get
  match 'search/tags' => 'search#tags', :as => :search_tags, :via => :get
  match 'search/reports' => 'search#reports', :as => :search_reports, :via => :get
  match 'search/studies' => 'search#studies', :as => :search_studies, :via => :get

end
