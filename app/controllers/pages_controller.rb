class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    render layout: 'landing'
  end

  def dashboard
    @courses = policy_scope(Course)
    authorize @courses
  end
end
