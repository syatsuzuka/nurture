Rails.application.routes.draw do
  devise_for :users
  get '/tutors/:id', to: 'users#show', as: :tutor
  get '/students/:id', to: 'users#show', as: :student
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment

  root to: 'pages#home'

  resources :courses do
    resources :assignments
  end
end
