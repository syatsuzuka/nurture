Rails.application.routes.draw do
  devise_for :users
  get '/tutors/:id', to: 'users#show', as: :user

  root to: 'pages#home'

  resources :courses do
    resources :assignments, only: %i[index new show create edit update]
  end
end
