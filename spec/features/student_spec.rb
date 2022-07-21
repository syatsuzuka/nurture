require 'rails_helper'
require_relative '../support/session_form'

feature 'student' do
  scenario 'accesses to student detail' do
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('students-menu')
    expect(page).to have_content('Student List')
    click_on('Sample Student')
    expect(page).to have_content('Sample Student')
    expect(page).to have_content('active user')
    expect(page).to have_content(ENV.fetch('SAMPLE_STUDENT_LOGIN_ID'))
    expect(page).to have_content('student')
  end
end
