Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
 get 'home/about' => 'homes#about'
 root to: 'books#top'
 get '/search' => 'search#search'
 devise_for :users
 resources :users do
   resource :showrelationships, only: [:create, :destroy]
   resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
 end
 
 resources :books do
  resource :favorites, only: [:create, :destroy] 
  resources :book_comments, only: [:create, :destroy]
 end
   
   
  

end
