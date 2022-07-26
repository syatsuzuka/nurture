class NotifyMessageJob < ApplicationJob
  queue_as :default

  def perform
    messages = Message.where(read: nil)
    mail_info = {}
    messages.each do |message|
      course = Course.find(message.chatroom.id)
      course.tutor.id == message.user.id ? user = course.student : user = course.tutor
      mail_info[user.id] = {} unless mail_info.key?(user.id)
      mail_info[user.id][course.id] = [] unless mail_info[user.id].key?(course.id)
      mail_info[user.id][course.id] << message.content
    end

    mail_info.each_key do |user_id|
      user = User.find(user_id)

      mail_info[user_id].each_key do |course_id|
        course = Course.find(course_id)
        course.tutor == user ? from = course.student : from = course.tutor

        if Rails.env.production?
          UserMailer.with(
            user: user,
            from: from,
            course: course,
            message_count: mail_info[user_id][course_id].count,
            path: "/#{I18n.locale}/courses/#{course_id}/assignments"
          ).notify_message_email.deliver_later
        else
          UserMailer.with(
            user: user,
            from: from,
            course: course,
            message_count: mail_info[user_id][course_id].count,
            path: "/#{I18n.locale}/courses/#{course_id}/assignments"
          ).notify_message_email.deliver_now
        end
      end
    end
  end
end
