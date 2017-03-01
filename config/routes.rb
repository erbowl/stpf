Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'posts#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :posts
  resources :users
end
