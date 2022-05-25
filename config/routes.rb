Rails.application.routes.draw do
  devise_for :users
  get '/tutors/:id', to: 'users#show', as: :user
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment

  root to: 'pages#home'

  resources :courses do

    resources :assignments, only: %i[index new show create edit update]
  end
end
