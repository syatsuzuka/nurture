require 'rails_helper'
require_relative '../support/new_session_form'

feature 'student' do
  scenario 'accesses to student menu' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Students')
    expect(page).to have_content('Student List')
  end

  scenario 'accesses to tutor menu' do
    new_session_options = { user_email: ENV['STUDENT_LOGIN_ID'], user_password: ENV['STUDENT_LOGIN_PASSWORD'] }
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with( new_session_options ).submit
    click_on('Tutors')
    expect(page).to have_content('Tutor List')
  end
end
