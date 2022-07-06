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

  def show_course_accept_request(course)
    if current_user.role == "tutor"
      case I18n.locale
      when :en
        "Newly created '#{course.name}' is waiting for the accept by #{course.student.nickname}"
      when :ja
        "新規作成された'#{course.name}'は #{course.student.nickname} の確認待ちです。"
      end
    else
      case I18n.locale
      when :en
        "Course #{course.name} created by #{link_to get_fullname(course.tutor), tutor_path(course.tutor)}" \
        + " is waiting for your accept. (#{link_to 'Accept now', accept_course_path(course)})"
      when :ja
        "#{link_to get_fullname(course.tutor), tutor_path(course.tutor)} により作成されたコース #{course.name}" \
        + "はあなたの確認待ちです。 (#{link_to '確認する', accept_course_path(course)})"
      end
    end
  end

  def show_no_homework_message
    if current_user.role == "tutor"
      emoji = emojify(':thinking:')
    else
      emoji = emojify(':tada::tada::tada:')
    end

    case I18n.locale
    when :en
      "(No Homework remained <span class='ms-2'>#{emoji}</span>)"
    when :ja
      "(残っている課題はありません <span class='ms-2'>#{emoji}</span>)"
    end
  end
end
