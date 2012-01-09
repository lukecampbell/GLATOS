Glatos::Application.routes.draw do

  root :to => 'home#index'
  match '/about' => 'home#about', :as => :about, :via => :get
  match '/acoustic_telemetry' => 'home#acoustic_telemetry', :as => :acoustic_telemetry, :via => :get

  devise_for :users

  resources :users, :only => [:index, :destroy, :update]
  resources :reports, :only => [:index, :new, :create, :destroy, :update] do
    get 'info', :on => :collection
  end

  resources :deployments, :only => [:index, :destroy]
  resources :studies, :only => [:index, :show] do
    resources :deployments, :only => [:index, :destroy]
    resources :reports, :only => [:index, :destroy, :update]
  end

  match 'explore' => 'explore#index', :as => :explore, :via => :get
  match 'search' => 'search#index', :as => :search, :via => :get
  match 'search/tags' => 'search#tags', :as => :search_tags, :via => :get
  match 'search/reports' => 'search#reports', :as => :search_reports, :via => :get
  match 'search/studies' => 'search#studies', :as => :search_studies, :via => :get
  match 'search/deployments' => 'search#deployments', :as => :search_deployments, :via => :get
  match 'search/tag' => 'search#tag', :as => :tag_search, :via => :get
  match 'search/match_tags' => 'search#match_tags', :as => :multi_tag_search, :via => :get

end
