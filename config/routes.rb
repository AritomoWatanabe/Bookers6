Rails.application.routes.draw do

  devise_for :users

  root 'top#top'

  get '/home/about' => 'top#index'



  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update, :set_book]

  resources :users, only: [:show, :edit, :update, :index]

end
