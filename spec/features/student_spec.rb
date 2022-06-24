require 'rails_helper'
require_relative '../support/new_session_form'

feature 'student' do
  scenario 'accesses to student detail' do
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit
    click_on('Students')
    expect(page).to have_content('Student List')
    click_on('Sample Student')
    expect(page).to have_content('Sample Student')
    expect(page).to have_content('active user')
    expect(page).to have_content(ENV['SAMPLE_STUDENT_LOGIN_ID'])
    expect(page).to have_content('student')
  end
end
