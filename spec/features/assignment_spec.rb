require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_assignment_form'

feature 'homework (assignment))' do
  scenario 'creates a new homework (assignment)' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to homework detail =======
    click_on('Homework')
    click_on('Smash Practice')
    expect(page).to have_content('Smash Practice')

    #======= Access to course detail =======
    click_on('Course Detail')
    expect(page).to have_content('Tennis Lesson (Intermediate)')

    #======= Add a new homework =======
    find('#add-assignment').click
    expect(page).to have_content('Add a New Homework')
    new_assignment_form = NewAssignmentForm.new
    assignment_params = {
      assignment_title: "test_title",
      assignment_instruction: "test_instruction",
      assignment_instruction_url: "https://www.nurture.pw",
      assignment_checkpoint: "test_checkpoint",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    new_assignment_form.fill_in_with(assignment_params).submit
    expect(page).to have_content('test_title')
  end

  scenario 'edits the existing homework (assignment)' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('Courses')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Add a new homework =======
    find('#assignments > table > tbody > tr:nth-child(1) > td > a.edit-assignment').click
    expect(page).to have_content('Edit the Homework')
    new_assignment_form = NewAssignmentForm.new
    assignment_params = {
      assignment_title: "test_title",
      assignment_instruction: "test_instruction",
      assignment_instruction_url: "https://www.nurture.pw",
      assignment_checkpoint: "test_checkpoint",
      assignment_status: "Work In Process",
      assignment_comment: "test_comment",
      assignment_material_url: "https://www.nurture.pw",
      assignment_review_comment: "test_review_comment",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    new_assignment_form.fill_in_with2(assignment_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('Work In Process')
    expect(page).to have_content('test_checkpoint')
    expect(page).to have_content('test_comment')
    expect(page).to have_content('test_review_comment')
    expect(page).to have_content('Jan.01, 2022')
    expect(page).to have_content('Dec.31, 2022')
  end
end
