require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/target_templates_set_form'

feature 'target_templates_set' do
  scenario 'creates a new target_templates_set' do
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
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 1

    #======= Create a new Target Templates Set =======
    target_templates_set_form = TargetTemplatesSetForm.new
    target_templates_set_params = {
      target_templates_set_name: "test_name",
      target_templates_set_category: "test_category",
      target_templates_set_visible: true
    }
    target_templates_set_form.visit_page.fill_in_with(target_templates_set_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_category')
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 2
  end

  scenario 'edits an existing target_templates_set' do
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
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 1

    #======= Edit an existing Target Templates Set =======
    find("#target-templates-sets > tbody > tr:nth-child(1) > td > a.edit-target-templates-set").click
    target_templates_set_form = TargetTemplatesSetForm.new
    target_templates_set_params = {
      target_templates_set_name: "test_name",
      target_templates_set_category: "test_category",
      target_templates_set_visible: true
    }
    target_templates_set_form.fill_in_with(target_templates_set_params).submit
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_category')
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 1
  end

  scenario 'deletes an existing target_templates_set' do
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
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 1

    #======= Delete an existing Target Templates Set =======
    find("#target-templates-sets > tbody > tr:nth-child(1) > td > a.delete-target-templates-set").click
    expect(page).to have_content('Template')
    expect(page.all('#target-templates-sets > tbody > tr').count).to eq 0
  end
end
