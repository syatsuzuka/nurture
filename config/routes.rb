Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  get '/assignments', to: 'assignments#all', as: :all_assignments
  get '/tutors/', to: 'users#index', as: :tutors
  get '/tutors/:id', to: 'users#show', as: :tutor
  get '/students/', to: 'users#index', as: :students
  get '/students/:id', to: 'users#show', as: :student
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  put '/courses/:course_id/assignments/:id/close', to: 'assignments#close', as: :close_course_assignment

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
