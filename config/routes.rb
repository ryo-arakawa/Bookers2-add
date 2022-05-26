Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:new, :create, :update, :index, :show, :edit, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
  get 'home/about' => 'homes#about',as:'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
