require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/assignment_templates_set_form'

feature 'assignment_templates_set' do
  scenario 'creates a new assignment_templates_set' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Template menu =======
    click_on('Template')
    expect(page).to have_content('Template')

    #======= Create a new Assignment Templates Set =======
    assignment_templates_set_form = AssignmentTemplatesSetForm.new
    assignment_templates_set_params = {
      assignment_templates_set_name: "test_name",
      assignment_templates_set_category: "test_category",
      assignment_templates_set_visible: true
    }
    assignment_templates_set_form.visit_page.fill_in_with(assignment_templates_set_params).submit
    expect(page).to have_content('test_name')
  end
end
