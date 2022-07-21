class ApplicationMailer < ActionMailer::Base
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV.fetch('MAIL_ADDRESS')
  layout 'mailer'
end
