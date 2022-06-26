require 'rails_helper'
require_relative '../support/session_form'

feature 'tutor' do
  scenario 'accesses to tutor detail' do
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('tutors-menu')
    expect(page).to have_content('Tutor List')
    click_on('Sample Tutor')
    expect(page).to have_content('Sample Tutor')
    expect(page).to have_content('active user')
    expect(page).to have_content(ENV['SAMPLE_TUTOR_LOGIN_ID'])
    expect(page).to have_content('tutor')
  end
end
