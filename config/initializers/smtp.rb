ActionMailer::Base.smtp_settings = {
  address: ENV['MAIL_SERVER'],
  port: ENV['MAIL_PORT'],
  domain: ENV['MAIL_DOMAIN'],
  user_name: ENV['MAIL_ADDRESS'],
  password: ENV['MAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
