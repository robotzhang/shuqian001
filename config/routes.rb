Shuqian001::Application.routes.draw do
  root :to => 'application#index'
  get "feedback" => 'application#feedback'

  devise_for :users
  resources :users
  #get 'users/:id' => 'users#index'

  resources :links

  scope ':commentable_type/:commentable_id' do
    resources :comments
  end

  scope ':votable_type/:votable_id' do
    resources :votes
  end

  resources :collections, :path => 'heji' do
    #resources :comments
    member do
      get :links
    end
  end
end
