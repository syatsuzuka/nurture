require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_assignment_templates_set_form'

feature 'assignment_templates_set' do
  scenario 'creates a new assignment_templates_set' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Template menu =======
    click_on('Template')
    expect(page).to have_content('Template')

    #======= Create a new Assignment Templates Set =======
    new_assignment_templates_set_form = NewAssignmentTemplatesSetForm.new
    assignment_templates_set_params = {
      assignment_templates_set_name: "test_name",
      assignment_templates_set_category: "test_category",
      assignment_templates_set_visible: true
    }
    new_assignment_templates_set_form.visit_page.fill_in_with(assignment_templates_set_params).submit
    expect(page).to have_content('test_name')
  end
end
