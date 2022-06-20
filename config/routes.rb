Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  get '/courses/:id/accept', to: 'courses#accept', as: :accept_course
  get '/assignments', to: 'assignments#all', as: :all_assignments
  get '/courses/:course_id/assignments/export.csv', to: 'assignments#export', as: :export_course_assignments
  get '/courses/:course_id/assignments/upload', to: 'assignments#upload', as: :upload_course_assignments
  post '/courses/:course_id/assignments/import', to: 'assignments#import', as: :import_course_assignments
  get '/courses/:course_id/assignments/:id/review', to: 'assignments#review', as: :review_course_assignment
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment
  put '/courses/:course_id/assignments/:id/close2', to: 'assignments#close2', as: :close2_course_assignment
  put '/courses/:course_id/assignments/:id/done', to: 'assignments#done', as: :done_course_assignment
  get '/courses/:course_id/targets/export.csv', to: 'targets#export', as: :export_course_targets
  get '/courses/:course_id/targets/upload', to: 'targets#upload', as: :upload_course_targets
  post '/courses/:course_id/targets/import', to: 'targets#import', as: :import_course_targets
  get '/courses/:course_id/targets/:target_id/progresses/export.csv', to: 'progresses#export', as: :export_progresses
  get '/courses/:course_id/targets/:target_id/progresses/upload', to: 'progresses#upload', as: :upload_progresses
  post '/courses/:course_id/targets/:target_id/progresses/import', to: 'progresses#import', as: :import_progresses
  get '/tutors/', to: 'users#index', as: :tutors
  get '/tutors/:id', to: 'users#show', as: :tutor
  get '/students/', to: 'users#index', as: :students
  get '/students/:id', to: 'users#show', as: :student
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  get '/knowledge', to: 'pages#knowledge', as: :knowledge
  get '/aboutus', to: 'pages#aboutus', as: :aboutus

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end

  resources :courses, only: %i[index new create edit update destroy] do
    resources :assignments, only: %i[index show new create edit update destroy]
    resources :targets, only: %i[new create edit update destroy] do
      resources :progresses, only: %i[index new create edit update destroy]
    end
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :tutors, only: %i[index show] do
    resources :reviews, only: %i[new create edit update destroy]
  end

  resources :target_templates_sets
  resources :homework_templates_sets
end
