Shuqian001::Application.routes.draw do
  root :to => 'application#index'

  devise_for :users
  resources :users
  #get 'users/:id' => 'users#index'

  resources :links

  scope ':commentable_type/:commentable_id' do
    resources :comments
  end

  resources :collections, :path => 'heji' do
    #resources :comments
    member do
      get :links
    end
  end
end
