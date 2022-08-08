Rails.application.routes.draw do
  # RailsAdmin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope "(:locale)", locale: /en|ja|ko/ do
    root to: 'pages#home'
  end

  scope "/:locale" do
    devise_for :users

    get '/courses/:id/accept', to: 'courses#accept', as: :accept_course
    get '/assignments', to: 'assignments#all', as: :all_assignments
    get '/courses/:course_id/assignments/export.csv', to: 'assignments#export', as: :export_course_assignments
    get '/courses/:course_id/assignments/upload', to: 'assignments#upload', as: :upload_course_assignments
    post '/courses/:course_id/assignments/import', to: 'assignments#import', as: :import_course_assignments
    get '/courses/:course_id/assignments/:id/review', to: 'assignments#review', as: :review_course_assignment
    put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment
    get '/courses/:course_id/targets/export.csv', to: 'targets#export', as: :export_course_targets
    get '/courses/:course_id/targets/upload', to: 'targets#upload', as: :upload_course_targets
    post '/courses/:course_id/targets/import', to: 'targets#import', as: :import_course_targets
    get '/courses/:course_id/targets/:target_id/progresses/export.csv', to: 'progresses#export', as: :export_progresses
    get '/courses/:course_id/targets/:target_id/progresses/upload', to: 'progresses#upload', as: :upload_progresses
    post '/courses/:course_id/targets/:target_id/progresses/import', to: 'progresses#import', as: :import_progresses
    get '/target_templates_sets/:target_templates_set_id/target_templates/export.csv',
        to: 'target_templates#export',
        as: :export_target_templates
    get '/target_templates_sets/:target_templates_set_id/target_templates/upload',
        to: 'target_templates#upload',
        as: :upload_target_templates
    post  '/target_templates_sets/:target_templates_set_id/target_templates/import',
          to: 'target_templates#import',
          as: :import_target_templates
    get '/assignment_templates_sets/:assignment_templates_set_id/assignment_templates/export.csv',
        to: 'assignment_templates#export',
        as: :export_assignment_templates
    get '/assignment_templates_sets/:assignment_templates_set_id/assignment_templates/upload',
        to: 'assignment_templates#upload',
        as: :upload_assignment_templates
    post  '/assignment_templates_sets/:assignment_templates_set_id/assignment_templates/import',
          to: 'assignment_templates#import',
          as: :import_assignment_templates
    get '/tutors/', to: 'users#index', as: :tutors
    get '/tutors/:id', to: 'users#show', as: :tutor
    get '/students/', to: 'users#index', as: :students
    get '/students/:id', to: 'users#show', as: :student
    get '/dashboard', to: 'pages#dashboard', as: :dashboard
    get '/report', to: 'pages#report', as: :report
    get '/report/print', to: 'pages#print_report', as: :print_report
    get '/template', to: 'pages#template', as: :template
    get '/knowledge', to: 'pages#knowledge', as: :knowledge
    get '/docs', to: 'pages#docs', as: :docs
    get '/company', to: 'pages#company', as: :company
    # get '/aboutus', to: 'pages#aboutus', as: :aboutus
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

    resources :target_templates_sets, only: %i[new create edit update destroy] do
      resources :target_templates, only: %i[index new create edit update destroy]
    end

    resources :assignment_templates_sets, only: %i[new create edit update destroy] do
      resources :assignment_templates, only: %i[index new create edit update destroy]
    end

    resources :posts do
      resources :comments
    end

    resources :likes, only: %i[create destroy]
  end
end
