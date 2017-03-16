Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'users#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                      :sessions=>"users/sessions",:passwords=>"users/passwords",:registrations=>"users/registrations"}
  resources :posts
  resources :users
  get 'cheers/:id',to: "users#cheer",as: "cheer"
  get 'search',to:"users#search",as:"search"
end
