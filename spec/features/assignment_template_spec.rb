require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_assignment_template_form'

feature 'homework template (assignment_template)' do
  scenario 'creates a new homework template' do
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
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('test_checkpoint')
  end

  scenario 'uploads new assignment templates' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('Template')
    find('#assignment-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Assignment Template =======
    find('#upload-assignment-template').click
    attach_file('file', 'public/sample/nurture_homework_template_sample.csv')
    click_on('Import')
    expect(page).to have_content('test')
    expect(page).to have_content('test2')
    expect(page).to have_content('test3')
  end

  scenario 'edits new assignment templates' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('Template')
    find('#assignment-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Assignment Template =======
    find('#assignment_templates > tbody > tr:nth-child(1) > td > a.edit-assignment_template').click
    new_assignment_template_form = NewAssignmentTemplateForm.new
    assignment_template_params = {
      assignment_template_title: "test_title",
      assignment_template_instruction: "test_instruction",
      assignment_template_instruction_url: "https://www.nurture.pw",
      assignment_template_checkpoint: "test_checkpoint"
    }
    new_assignment_template_form.fill_in_with(assignment_template_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('test_checkpoint')
  end
end
