class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    render layout: 'landing'
  end

  def dashboard
    @courses = policy_scope(Course)
    authorize @courses

    @data = []
    @courses.each do |course|
      data_hash = []
      course.targets.each do |target|
        progresses = Progress.where(target: target).order(date: :asc)
        data = progresses.map do |progress|
          [progress.date.strftime("%F"), progress.score]
        end
        data_hash << { name: target.name, data: data }
      end
      @data << data_hash
    end
  end

  def aboutus
  end
end
