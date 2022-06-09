class NewUserForm
  include Capybara::DSL

  def visit_page
    visit('/users/sign_up')
    self
  end

  def fill_in_with(params = {})
    fill_in('user_email', with: params.fetch(:user_email, ENV['TEST_LOGIN_ID']))
    fill_in('user_password', with: params.fetch(:user_password, ENV['TEST_LOGIN_PASSWORD']))
    fill_in('user_password_confirmation', with: params.fetch(:user_password, ENV['TEST_LOGIN_PASSWORD']))
    fill_in('user_first_name', with: params.fetch(:user_first_name, 'First'))
    fill_in('user_last_name', with: params.fetch(:user_last_name, 'Last'))
    fill_in('user_nickname', with: params.fetch(:user_nickname, 'testuser'))
    select(params.fetch(:user_role, 'tutor'), from: 'user_role')
    self
  end

  def submit
    click_button('Sign up')
    self
  end
end
