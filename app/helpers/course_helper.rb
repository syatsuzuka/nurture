module CourseHelper
  def show_course_accept_request(course)
    if current_user.role == "tutor"
      case I18n.locale
      when :en
        "Newly created '#{course.name}' is waiting for the accept by #{course.student.nickname}"
      when :ja
        "新規作成された'#{course.name}'は #{course.student.nickname} の確認待ちです。"
      when :ko  # rubocop:disable Lint/DuplicateBranch
        "Newly created '#{course.name}' is waiting for the accept by #{course.student.nickname}"
      end
    else
      case I18n.locale
      when :en
        "Course #{course.name} created by #{link_to get_fullname(course.tutor), tutor_path(course.tutor)}" \
        + " is waiting for your accept. (#{link_to 'Accept now', accept_course_path(course)})"
      when :ja
        "#{link_to get_fullname(course.tutor), tutor_path(course.tutor)} により作成されたコース #{course.name}" \
        + "はあなたの確認待ちです。 (#{link_to '確認する', accept_course_path(course)})"
      when :ko  # rubocop:disable Lint/DuplicateBranch
        "Course #{course.name} created by #{link_to get_fullname(course.tutor), tutor_path(course.tutor)}" \
        + " is waiting for your accept. (#{link_to 'Accept now', accept_course_path(course)})"
      end
    end
  end
end
