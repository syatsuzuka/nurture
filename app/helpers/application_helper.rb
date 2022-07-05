module ApplicationHelper
  # For serverside rendering of pagination
  include Pagy::Frontend

  def add_image(course, filename, options = {})
    if defined? course.photo.key
      cl_image_tag(course.photo.key, options)
    else
      image_tag(filename, options)
    end
  end

  def due_alert(assignment)
    unless assignment.end_date.nil?
      if (assignment.end_date - Date.today).to_i < 10 && (assignment.end_date - Date.today).to_i.positive?
        "#{distance_of_time_in_words(Time.now, assignment.end_date + 1)} left"
      end
    end
  end

  def get_fullname(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def show_add_button
    "<span class='btn btn-success text-light'><i class='fas fa-plus'></i> #{t('actions.add')}</span>"
  end

  def show_upload_button
    "<span class='btn btn-success text-light'><i class='fas fa-upload'></i> #{t('actions.upload')}</span>"
  end

  def show_download_button
    "<span class='btn btn-success text-light'><i class='fas fa-download'></i> #{t('actions.download')}</span>"
  end
end
