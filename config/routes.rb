Shuqian001::Application.routes.draw do
  root :to => 'application#index'
  get "feedback" => 'application#feedback'
  get "helps" => 'application#helps'

  devise_for :users
  resources :users do
     member do
       post :follow, :unfollow
     end
  end
  #get 'users/:id' => 'users#index'

  post "link_groups" => "links#group"
  resources :links

  scope ':commentable_type/:commentable_id' do
    resources :comments
  end

  scope ':votable_type/:votable_id' do
    resources :votes
  end

  scope ':likable_type/:likable_id' do
    resources :likes
  end

  resources :collections, :path => 'heji' do
    #resources :comments
    member do
      get :links
    end
  end
  get "tags/:tag" => "collections#tags"
end
