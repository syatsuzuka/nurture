require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_assignment_form'

feature 'homework (assignment))' do
  scenario 'creates a new homework (assignment)' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to homework detail =======
    click_on('Homework')
    click_on('Smash Practice')
    expect(page).to have_content('Smash Practice')

    #======= Access to course detail =======
    click_on('Course Detail')
    expect(page).to have_content('Tennis Lesson (Intermediate)')

    #======= Add a new homework =======
    find('#add-assignment').click
    expect(page).to have_content('Add a New Homework')
    new_assignment_form = NewAssignmentForm.new
    assignment_params = {
      assignment_title: "test_title",
      assignment_instruction: "test_instruction",
      assignment_instruction_url: "https://www.nurture.pw",
      assignment_checkpoint: "test_checkpoint",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    new_assignment_form.fill_in_with(assignment_params).submit
    expect(page).to have_content('test_title')
  end
end
