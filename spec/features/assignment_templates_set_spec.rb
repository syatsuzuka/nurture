require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/assignment_templates_set_form'

feature 'assignment_templates_set' do
  scenario 'creates a new assignment_templates_set' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Template menu =======
    click_on('template-menu')
    expect(page).to have_content('Template')
    expect(page).to have_no_content('test_name')
    expect(page).to have_no_content('test_category')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 1

    #======= Create a new Assignment Templates Set =======
    assignment_templates_set_form = AssignmentTemplatesSetForm.new
    assignment_templates_set_params = {
      assignment_templates_set_name: "test_name",
      assignment_templates_set_category: "test_category",
      assignment_templates_set_visible: true
    }
    assignment_templates_set_form.visit_page.fill_in_with(assignment_templates_set_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_category')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 2
  end

  scenario 'edits an existing assignment_templates_set' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Template menu =======
    click_on('template-menu')
    expect(page).to have_content('Template')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 1

    #======= Edit an existing Assignment Templates Set =======
    find("#assignment-templates-sets > tbody > tr:nth-child(1) > td > a.edit-assignment-templates-set").click
    assignment_templates_set_form = AssignmentTemplatesSetForm.new
    assignment_templates_set_params = {
      assignment_templates_set_name: "test_name",
      assignment_templates_set_category: "test_category",
      assignment_templates_set_visible: true
    }
    assignment_templates_set_form.fill_in_with(assignment_templates_set_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_category')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 1
  end

  scenario 'deletes an existing assignment_templates_set' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Template menu =======
    click_on('template-menu')
    expect(page).to have_content('Template')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 1

    #======= Delete an existing Assignment Templates Set =======
    find("#assignment-templates-sets > tbody > tr:nth-child(1) > td > a.delete-assignment-templates-set").click
    expect(page).to have_content('Template')
    expect(page.all('#assignment-templates-sets > tbody > tr').count).to eq 0
  end
end
