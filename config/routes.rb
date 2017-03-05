Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'users#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                      :sessions=>"users/sessions",:passwords=>"users/passwords}
  resources :posts
  resources :users
  get 'cheers/:id',to: "users#cheer",as: "cheer"
end
