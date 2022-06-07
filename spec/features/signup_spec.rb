require 'rails_helper'

feature 'create new user' do
  scenario 'create new user with valid data' do
    visit('/users/sign_up')
    fill_in('user_email', with: ENV['TEST_MAIL_ADDRESS'])
    fill_in('user_password', with: ENV['TEST_MAIL_PASSWORD'])
    fill_in('user_password_confirmation', with: ENV['TEST_MAIL_PASSWORD'])
    fill_in('user_first_name', with: 'First')
    fill_in('user_last_name', with: 'Last')
    fill_in('user_nickname', with: 'testuser')
    select('tutor', from: 'user_role')
    click_on('Sign up')
    expect(page).to have_content('Dashboard')
  end
end
