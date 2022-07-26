module AssignmentHelper
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
    when :ko # rubocop:disable Lint/DuplicateBranch
      "(No Homework remained <span class='ms-2'>#{emoji}</span>)"
    end
  end
end
