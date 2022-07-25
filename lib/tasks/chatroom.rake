namespace :chatroom do
  desc "Notify unread messages for users"
  task notify_user: :environment do
    if Rails.env.production?
      NotifyMessageJob.perform_later
    else
      NotifyMessageJob.perform_now
    end
  end
end
