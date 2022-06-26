require 'rails_helper'
require_relative '../support/user_form'
require_relative '../support/session_form'
require_relative '../support/navbar'

feature 'user' do
  scenario 'creates a new tutor' do
    user_form = UserForm.new
    user_params = {
      user_email: ENV['TEST_TUTOR_LOGIN_ID'],
      user_password: ENV['TEST_TUTOR_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['TEST_TUTOR_LOGIN_PASSWORD'],
      user_first_name: 'Test',
      user_last_name: 'Tutor',
      user_nickname: 'test-tutor',
      user_role: 'tutor'
    }
    user_form.visit_page.fill_in_with(user_params).submit
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Test Tutor')
  end

  scenario 'creates a new student' do
    user_form = UserForm.new
    user_params = {
      user_email: ENV['TEST_STUDENT_LOGIN_ID'],
      user_password: ENV['TEST_STUDENT_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['TEST_STUDENT_LOGIN_PASSWORD'],
      user_first_name: 'Test',
      user_last_name: 'Student',
      user_nickname: 'test-student',
      user_role: 'student'
    }
    user_form.visit_page.fill_in_with(user_params).submit
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Test Student')
  end
end
