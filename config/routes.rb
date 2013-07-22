Shuqian001::Application.routes.draw do
  root :to => 'application#index'
  resources :collections, :path => 'heji'
end
