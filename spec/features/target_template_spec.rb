require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/target_template_form'

feature 'target_template' do
  scenario 'creates a new target template' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Template =======
    click_on('template-menu')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_no_content('test_name')
    expect(page.all('#target_templates > tbody > tr').count).to eq 2

    #======= Create a new Target Template =======
    find('#add-target-template').click
    target_template_form = TargetTemplateForm.new
    target_template_params = {
      target_template_name: "test_name",
      target_template_parent_id: "",
      target_template_description: "test_description",
      target_template_score: 30
    }
    target_template_form.fill_in_with(target_template_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_description')
    expect(page).to have_content('30')
    expect(page.all('#target_templates > tbody > tr').count).to eq 3
  end

  scenario 'edits an existing target template' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Template =======
    click_on('template-menu')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_no_content('test_name')
    expect(page.all('#target_templates > tbody > tr').count).to eq 2

    #======= Edit an existing Target Template =======
    find('#target_templates > tbody > tr:nth-child(1) > td > a.edit-target_template').click
    target_template_form = TargetTemplateForm.new
    target_template_params = {
      target_template_name: "test_name",
      target_template_parent_id: "",
      target_template_description: "test_description",
      target_template_score: 30
    }
    target_template_form.fill_in_with(target_template_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_description')
    expect(page).to have_content('30')
    expect(page.all('#target_templates > tbody > tr').count).to eq 2
  end

  scenario 'deletes an existing target template' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Template =======
    click_on('template-menu')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#target_templates > tbody > tr').count).to eq 2

    #======= Delete an existing Target Template =======
    find('#target_templates > tbody > tr:nth-child(1) > td > a.delete-target_template').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#target_templates > tbody > tr').count).to eq 1
  end

  scenario 'uploads new target templates' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Template =======
    click_on('template-menu')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#target_templates > tbody > tr').count).to eq 2

    #======= Create a new Target Template =======
    find('#upload-target-template').click
    attach_file('file', 'public/sample/nurture_target_template_sample.csv')
    click_on('Import')
    expect(page).to have_content('test')
    expect(page).to have_content('test > test2')
    expect(page).to have_content('test > test2 > test3')
    expect(page).to have_content('test > test2 > test3 > test4')
    expect(page.all('#target_templates > tbody > tr').count).to eq 6
  end

  scenario 'downloads target templates list' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Template =======
    click_on('template-menu')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Target Template =======
    find('#download-target-template').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
  end
end
