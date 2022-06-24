require 'rails_helper'
require_relative '../support/new_session_form'

feature 'tutor' do
  scenario 'accesses to tutor detail' do
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit
    click_on('Tutors')
    expect(page).to have_content('Tutor List')
    click_on('Sample Tutor')
    expect(page).to have_content('Sample Tutor')
    expect(page).to have_content('active user')
    expect(page).to have_content(ENV['SAMPLE_TUTOR_LOGIN_ID'])
    expect(page).to have_content('tutor')
  end
end
