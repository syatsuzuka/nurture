module DashboardHelper
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
