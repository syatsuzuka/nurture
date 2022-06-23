require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_target_form'

feature 'target' do
  scenario 'creates a new target' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Setting =======
    click_on('Courses')
    click_on('Tennis Lesson (Intermediate)')
    expect(page).to have_content('Tennis Lesson (Intermediate)')

    #======= Create a new Target =======
    find('#add-target').click
    new_target_form = NewTargetForm.new
    target_params = {
      target_name: "test_name",
      target_parent_id: "",
      target_description: "test_description",
      target_scope: 100,
      target_display: true
    }
    new_target_form.fill_in_with(target_params).submit
    expect(page).to have_content('test_name')
  end
end
