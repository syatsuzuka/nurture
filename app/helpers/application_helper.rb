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

  def sample_course?(current_user, course)
    return true if current_user.role == "tutor" && course.student.email == ENV["SAMPLE_STUDENT_LOGIN_ID"]
    return true if current_user.role == "student" && course.tutor.email == ENV["SAMPLE_TUTOR_LOGIN_ID"]

    false
  end

  def get_fullname(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def manager?(current_user, tutor)
    element = tutor
    until element.manager.nil?
      return true if element.manager == current_user

      element = element.manager
    end
    false
  end

  def tutor?(current_user, tutor)
    courses = Course.where(tutor: current_user, student: tutor)

    true if courses.any?
  end

  def student?(current_user, student)
    courses = Course.where(tutor: current_user, student: student)

    true if courses.any?
  end

  def show_add_button
    "<span class='btn btn-success text-light'><i class='fas fa-plus'></i> #{t('label.form.add')}</span>"
  end

  def show_upload_button
    "<span class='btn btn-success text-light'><i class='fas fa-upload'></i> #{t('label.form.upload')}</span>"
  end

  def show_download_button
    "<span class='btn btn-success text-light'><i class='fas fa-download'></i> #{t('label.form.download')}</span>"
  end

  def show_edit_button
    "<span class='btn btn-outline-success'><i class='fas fa-edit'></i></span>"
  end

  def show_delete_button
    "<span class='btn btn-outline-secondary'><i class='fas fa-trash-alt'></i></span>"
  end
end
