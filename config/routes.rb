Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :courses
  resources :assignments, only: %i[new show create]
end
