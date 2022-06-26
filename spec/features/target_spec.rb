require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/target_form'

feature 'target' do
  scenario 'creates a new target' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Setting =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Create a new Target =======
    find('#add-target').click
    target_form = TargetForm.new
    target_params = {
      target_name: "test_name",
      target_parent_id: "",
      target_description: "test_description",
      target_scope: 100,
      target_display: true
    }
    target_form.fill_in_with(target_params).submit
    expect(page).to have_content('test_name')
  end

  scenario 'Uploads new targets' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Setting =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Upload new Targets =======
    find('#upload-target').click
    attach_file('file', 'public/sample/nurture_target_sample.csv')
    click_on('Import')
    expect(page).to have_content('test')
    expect(page).to have_content('test > test2')
    expect(page).to have_content('test > test2 > test3')
    expect(page).to have_content('test > test2 > test3 > test4')
  end

  scenario 'edits an existing target' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target Setting =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Edits Target =======
    find('#targets > table > tbody >tr:nth-child(1) > td a.edit-target').click
    target_form = TargetForm.new
    target_params = {
      target_name: "test_name",
      target_parent_id: "",
      target_description: "test_description",
      target_scope: 100,
      target_display: true
    }
    target_form.fill_in_with(target_params).submit
    expect(page).to have_content('test_name')
  end
end
