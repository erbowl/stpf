Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  devise_for :users
  get 'users/:id' => 'users#show'
  get '/:nickname' => 'users#nickname'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
