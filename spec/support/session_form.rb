class SessionForm
  include Capybara::DSL

  def visit_page
    visit('/en/users/sign_in')
    self
  end

  def fill_in_with(params = {})
    fill_in('user_email', with: params.fetch(:user_email, ENV.fetch('DEMO_TUTOR_LOGIN_ID')))
    fill_in('user_password', with: params.fetch(:user_password, ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')))
    self
  end

  def submit
    click_button('Sign in')
    self
  end

  def logout
    find('#logout-menu').click
    self
  end
end
