Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :courses do
<<<<<<< HEAD
    resources :assignment, only: %i[index show edit]
=======
    resources :assignments, only: %i[edit]
>>>>>>> master
  end
end
