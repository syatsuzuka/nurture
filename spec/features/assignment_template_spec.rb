require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/assignment_template_form'

feature 'homework template (assignment_template)' do
  scenario 'creates a new homework template' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 1

    #======= Create a new Assignment Template =======
    find('#add-assignment-template').click
    assignment_template_form = AssignmentTemplateForm.new
    assignment_template_params = {
      assignment_template_title: "test_title",
      assignment_template_instruction: "test_instruction",
      assignment_template_instruction_url: "https://www.nurture.pw",
      assignment_template_checkpoint: "test_checkpoint"
    }
    assignment_template_form.fill_in_with(assignment_template_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('test_checkpoint')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 2
  end

  scenario 'edits an existing assignment templates' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 1

    #======= Edit an existing Assignment Template =======
    find('#assignment_templates > tbody > tr:nth-child(1) > td > a.edit-assignment_template').click
    assignment_template_form = AssignmentTemplateForm.new
    assignment_template_params = {
      assignment_template_title: "test_title",
      assignment_template_instruction: "test_instruction",
      assignment_template_instruction_url: "https://www.nurture.pw",
      assignment_template_checkpoint: "test_checkpoint"
    }
    assignment_template_form.fill_in_with(assignment_template_params).submit
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('test_checkpoint')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 1
  end

  scenario 'deletes an existing assignment templates' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 1

    #======= Delete an existing Assignment Template =======
    find('#assignment_templates > tbody > tr:nth-child(1) > td > a.delete-assignment_template').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 0
  end

  scenario 'uploads new assignment templates' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 1

    #======= Create a new Assignment Template =======
    find('#upload-assignment-template').click
    attach_file('file', 'public/sample/nurture_homework_template_sample.csv')
    click_on('Upload')
    expect(page).to have_content('Sample')
    expect(page).to have_content('Sample2')
    expect(page).to have_content('Sample3')
    expect(page.all('#assignment_templates > tbody > tr').count).to eq 4
  end

  scenario 'export assignment templates list with owner' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Assignment Template =======
    find('#download-assignment-template').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
  end

  scenario 'export assignment templates list with other tutor' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR2_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR2_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Assignment Template =======
    click_on('template-menu')
    find('#assignment-templates-sets > div > div.card:nth-child(1) > div.card-body > div:nth-child(2) > a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Assignment Template =======
    find('#download-assignment-template').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
  end
end
