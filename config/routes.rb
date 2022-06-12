Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  get '/assignments', to: 'assignments#all', as: :all_assignments
  get '/courses/:course_id/assignments/:id/review', to: 'assignments#review', as: :review_course_assignment
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment
  put '/courses/:course_id/assignments/:id/close2', to: 'assignments#close2', as: :close2_course_assignment
  put '/courses/:course_id/assignments/:id/done', to: 'assignments#done', as: :done_course_assignment
  get '/courses/:course_id/targets/upload', to: 'targets#upload', as: :upload_course_targets
  post '/courses/:course_id/targets/import', to: 'targets#import', as: :import_course_targets
  get '/courses/:course_id/targets/:target_id/progresses/export.csv', to: 'progresses#export', as: :export_progresses
  get '/tutors/', to: 'users#index', as: :tutors
  get '/tutors/:id', to: 'users#show', as: :tutor
  get '/students/', to: 'users#index', as: :students
  get '/students/:id', to: 'users#show', as: :student
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  get '/aboutus', to: 'pages#aboutus', as: :aboutus

  resources :courses do
    resources :assignments
    resources :targets do
      resources :progresses
    end
  end

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
