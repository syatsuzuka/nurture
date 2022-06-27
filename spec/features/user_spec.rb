require 'rails_helper'
require_relative '../support/user_form'
require_relative '../support/session_form'

feature 'user' do
  scenario 'creates a new tutor' do
    #======= Signup as a Tutor =======
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

  scenario 'updates an existing tutor' do
    #======= Login as a Student =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Change User Setting =======
    user_form = UserForm.new
    user_params = {
      user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['DEMO_TUTOR_LOGIN_PASSWORD'],
      user_current_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'],
      user_first_name: 'FirstName',
      user_last_name: 'LastName',
      user_nickname: 'test_nickname',
      user_message: 'test_message',
      user_specialty: 'test_specialty',
      user_visible: true,
      user_role: 'tutor'
    }
    user_form.visit_setting_page.fill_in_setting_with(user_params).save

    #======= Logout =======
    session_form.logout

    #======= Login as a Student =======
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Check the updated Tutor info =======
    click_on('tutors-menu')
    click_on('FirstName LastName')

    expect(page).to have_content('FirstName LastName')
    expect(page).to have_content('active user')
    expect(page).to have_content('demo-tutor@nurture.pw')
    expect(page).to have_content('test_nickname')
    expect(page).to have_content('test_message')
    expect(page).to have_content('test_specialty')
  end

  scenario 'creates a new student' do
    #======= Signup as a Tutor =======
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

  scenario 'updates an existing student' do
    #======= Login as a Student =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Change User Setting =======
    user_form = UserForm.new
    user_params = {
      user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'],
      user_password_confirmation: ENV['DEMO_STUDENT_LOGIN_PASSWORD'],
      user_current_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'],
      user_first_name: 'FirstName',
      user_last_name: 'LastName',
      user_nickname: 'test_nickname',
      user_message: 'test_message',
      user_specialty: 'test_interest',
      user_visible: true,
      user_role: 'student'
    }
    user_form.visit_setting_page.fill_in_setting_with(user_params).save

    #======= Logout =======
    session_form.logout

    #======= Login as a Student =======
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Check the updated Tutor info =======
    click_on('students-menu')
    click_link('FirstName LastName')

    expect(page).to have_content('FirstName LastName')
    expect(page).to have_content('active user')
    expect(page).to have_content('demo-student@nurture.pw')
    expect(page).to have_content('test_nickname')
    expect(page).to have_content('student')
    expect(page).to have_content('test_message')
    expect(page).to have_content('test_interest')
  end
end
