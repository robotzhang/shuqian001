Shuqian001::Application.routes.draw do
  devise_for :users

  root :to => 'application#index'
  resources :links
  resources :collections, :path => 'heji' do
    member do
      get :links
    end
  end
end
