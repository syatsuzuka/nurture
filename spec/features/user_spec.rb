require 'rails_helper'
require_relative '../support/new_user_form'
require_relative '../support/new_session_form'
require_relative '../support/navbar'

feature 'user' do
  scenario 'creates a new tutor' do
    new_user_form = NewUserForm.new
    user_params = {
      user_email: ENV['TEST_TUTOR_LOGIN_ID'],
      user_password: ENV['TEST_TUTOR_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['TEST_TUTOR_LOGIN_PASSWORD'],
      user_first_name: 'Test',
      user_last_name: 'Tutor',
      user_nickname: 'test-tutor',
      user_role: 'tutor'
    }
    new_user_form.visit_page.fill_in_with(user_params).submit
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Test Tutor')
  end

  scenario 'creates a new student' do
    new_user_form = NewUserForm.new
    user_params = {
      user_email: ENV['TEST_STUDENT_LOGIN_ID'],
      user_password: ENV['TEST_STUDENT_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['TEST_STUDENT_LOGIN_PASSWORD'],
      user_first_name: 'Test',
      user_last_name: 'Student',
      user_nickname: 'test-student',
      user_role: 'student'
    }
    new_user_form.visit_page.fill_in_with(user_params).submit
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Test Student')
  end
end
