Rails.application.routes.draw do
  devise_for :users
  
  # ログインできたらインデックスに飛ぶ 
  root 'books#index'

  resources :books, only: [:new, :create, :index, :show]
  
end
