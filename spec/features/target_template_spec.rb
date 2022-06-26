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
    click_on('Template')
    find('#target-templates-sets tbody tr td:nth-child(3) a').click
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Target Template =======
    find('#add-target-template').click
    target_template_form = TargetTemplateForm.new
    target_template_params = {
      target_template_name: "test_name",
      target_template_parent_id: "",
      target_template_description: "test_description",
      target_template_scope: 30
    }
    target_template_form.fill_in_with(target_template_params).submit
    expect(page).to have_content('test_name')
  end
end
