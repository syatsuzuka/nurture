class MailSendingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "test"
  end
end
