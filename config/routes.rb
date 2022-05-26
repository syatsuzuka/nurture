Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get '/assignments', to: 'assignments#all', as: :all_assignments
  get '/tutors/', to: 'users#index', as: :tutors
  get '/tutors/:id', to: 'users#show', as: :tutor
  get '/students/', to: 'users#index', as: :students
  get '/students/:id', to: 'users#show', as: :student
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment

  root to: 'pages#home'

  resources :courses do
    resources :assignments
  end

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end
end
