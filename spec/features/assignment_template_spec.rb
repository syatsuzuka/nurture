require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_assignment_template_form'

feature 'assignment_template' do
  scenario 'creates a new assignment template' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('Template')
    find('#assignment-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Assignment Template =======
    find('#add-assignment-template').click
    new_assignment_template_form = NewAssignmentTemplateForm.new
    assignment_template_params = {
      assignment_template_title: "test_title",
      assignment_template_instruction: "test_instruction",
      assignment_template_instruction_url: "https://www.nurture.pw",
      assignment_template_checkpoint: "test_checkpoint"
    }
    new_assignment_template_form.fill_in_with(assignment_template_params).submit
    expect(page).to have_content('test_title')
  end
end
