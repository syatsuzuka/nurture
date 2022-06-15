require 'rails_helper'
require_relative '../support/new_session_form'

feature 'tutor' do
  scenario 'accesses to tutor menu' do
    new_session_options = {
      user_email: ENV['DEMO_STUDENT_LOGIN_ID'],
      user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD']
    }
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with(new_session_options).submit
    click_on('Tutors')
    expect(page).to have_content('Tutor List')
  end
end
