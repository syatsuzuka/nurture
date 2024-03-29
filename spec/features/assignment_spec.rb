require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/assignment_form'

feature 'homework (assignment)' do
  scenario 'creates a new homework (assignment)' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Check the list of homework =======
    click_on('homework-menu')
    expect(page.all('main div.row > div').count).to eq 2

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_no_content('test_title')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1

    #======= Add a new homework =======
    find('#add-assignment').click
    expect(page).to have_content('Add a New Homework')
    assignment_form = AssignmentForm.new
    assignment_params = {
      assignment_title: "test_title",
      assignment_instruction: "test_instruction",
      assignment_instruction_url: "https://www.nurture.pw",
      assignment_checkpoint: "test_checkpoint",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    assignment_form.fill_in_new_with(assignment_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page.all('#assignments table > tbody > tr').count).to eq 2

    #======= Check the list of homework =======
    click_on('homework-menu')
    expect(page.all('main div.row > div').count).to eq 3

    #======= Logout =======
    session_form.logout

    #======= Login with Student ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Check the list of homework =======
    click_on('homework-menu')
    click_on('test_title')
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('https://www.nurture.pw')
    expect(page).to have_content('Jan.01, 2022')
    expect(page).to have_content('Dec.31, 2022')
  end

  scenario 'edits the existing homework (assignment)' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_no_content('test_title')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1

    #======= Edit an existing homework =======
    find('#assignments table > tbody > tr:nth-child(1) > td > a.edit-assignment').click
    expect(page).to have_content('Edit the Homework')
    assignment_form = AssignmentForm.new
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
    assignment_form.fill_in_edit_with(assignment_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_instruction')
    expect(page).to have_content('Work In Process')
    expect(page).to have_content('2022-01-01')
    expect(page).to have_content('2022-12-31')

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_content('test_title')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1
  end

  scenario 'deletes the existing homework (assignment)' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_content('Swing Practice every day')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1

    #======= Delete an existing homework =======
    find('#assignments table > tbody > tr:nth-child(1) > td > a.delete-assignment').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_no_content('Swing Practice every day')
    expect(page.all('#assignments table > tbody > tr').count).to eq 0
  end

  scenario 'uploads new homeworks (assignment)' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1

    #======= Add a new homework =======
    find('#upload-assignment').click
    attach_file('file', 'public/sample/nurture_homework_sample.csv')
    click_on('Upload')
    expect(page).to have_content('Sample')
    expect(page).to have_content('Sample2')
    expect(page).to have_content('Sample3')
    expect(page.all('#assignments table > tbody > tr').count).to eq 4
  end

  scenario 'review and close a homework (assignment)' do
    #======= Login with Student ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1

    #======= Change the status of homework =======
    find('#assignments table > tbody > tr:nth-child(1) > td > a.edit-assignment').click
    expect(page).to have_content('Edit the Homework')
    assignment_form = AssignmentForm.new
    assignment_params = {
      assignment_status: "Done",
      assignment_comment: "test_comment",
      assignment_material_url: "https://www.nurture.pw",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    assignment_form.fill_in_done_with(assignment_params).submit
    expect(page).to have_content('Done')
    expect(page).to have_content('2022-01-01')
    expect(page).to have_content('2022-12-31')

    #======= Logout =======
    session_form.logout

    #======= Login with Tutor ID =======
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Review the homework =======
    expect(page).to have_content('Waiting for your review!')
    click_on('Swing Practice every day')
    click_on('Add your review?')
    assignment_params = {
      assignment_status: "Done",
      assignment_review_comment: "test_review_comment",
      assignment_start_date: "2022-01-01",
      assignment_end_date: "2022-12-31"
    }
    assignment_form.fill_in_review_with(assignment_params).submit
    expect(page).to have_content('Done')
    expect(page).to have_content('2022-01-01')
    expect(page).to have_content('2022-12-31')

    #======= Check "Mark as completed" =======
    click_on('Swing Practice every day')
    click_on('Mark as completed')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page).to have_content('Closed')

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')
    expect(page.all('#assignments table > tbody > tr').count).to eq 1
  end

  scenario 'exports homework (assignment) list' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to course detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    expect(page).to have_content('Tennis Lesson (Beginner)')

    #======= Edit an existing homework =======
    find('#download-assignment').click
    expect(page).to have_content('Tennis Lesson (Beginner)')
  end
end
