Shuqian001::Application.routes.draw do
  root :to => 'application#index'
  post 'links' => 'links#create'
  resources :collections, :path => 'heji' do
    resources :links
  end
end
