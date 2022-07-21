class UserForm
  include Capybara::DSL

  def visit_page
    visit('/en/users/sign_up')
    self
  end

  def visit_setting_page
    click_on('setting-menu')
    self
  end

  def fill_in_with(params = {})
    fill_in('user_email', with: params.fetch(:user_email, ENV.fetch('TEST_TUTOR_LOGIN_ID')))
    fill_in('user_password', with: params.fetch(:user_password, ENV.fetch('TEST_TUTOR_LOGIN_PASSWORD')))
    fill_in('user_password_confirmation', with: params.fetch(:user_password, ENV.fetch('TEST_TUTOR_LOGIN_PASSWORD')))
    fill_in('user_first_name', with: params.fetch(:user_first_name, 'Test'))
    fill_in('user_last_name', with: params.fetch(:user_last_name, 'User'))
    fill_in('user_nickname', with: params.fetch(:user_nickname, 'testuser'))
    select(params.fetch(:user_role, 'tutor'), from: 'user_role')
    self
  end

  def submit
    click_button('Sign up')
    self
  end

  def fill_in_setting_with(params = {})
    fill_in('user_password', with: params.fetch(:user_password, ENV.fetch('TEST_TUTOR_LOGIN_PASSWORD')))
    fill_in('user_password_confirmation', with: params.fetch(:user_password, ENV.fetch('TEST_TUTOR_LOGIN_PASSWORD')))
    fill_in('user_current_password', with: params.fetch(:user_current_password, ENV.fetch('TEST_TUTOR_LOGIN_PASSWORD')))
    fill_in('user_first_name', with: params.fetch(:user_first_name, 'FirstName'))
    fill_in('user_last_name', with: params.fetch(:user_last_name, 'LastName'))
    fill_in('user_nickname', with: params.fetch(:user_nickname, 'testuser'))
    fill_in('user_message', with: params.fetch(:user_message, 'test_message'))

    if params.fetch(:user_role) == "tutor"
      fill_in('user_specialty', with: params.fetch(:user_specialty, 'test_specialty'))
    else
      fill_in('user_interest', with: params.fetch(:user_interest, 'test_interest'))
    end

    if params.fetch(:user_visible)
      check('user_visible')
    else
      uncheck('user_visible')
    end
    self
  end

  def save
    click_button('Save')
    self
  end
end
