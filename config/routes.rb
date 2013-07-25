Shuqian001::Application.routes.draw do
  root :to => 'application#index'

  devise_for :users
  resources :users
  #get 'users/:id' => 'users#index'

  resources :links
  resources :collections, :path => 'heji' do
    member do
      get :links
    end
  end
end
