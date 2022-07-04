require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/progress_form'

feature 'progress' do
  scenario 'creates a new progress with tutor account' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page).to have_no_content('test_comment')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9

    #======= Create a new Progress =======
    find('#add-progress').click
    progress_form = ProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_score: 100,
      progress_comment: "test_comment"
    }
    progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('test_comment')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 10
  end

  scenario 'creates a new progress with student account' do
    #======= Login with Student ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page).to have_no_content('test_comment')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9

    #======= Create a new Progress =======
    find('#add-progress').click
    progress_form = ProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_score: 100,
      progress_comment: "test_comment"
    }
    progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('test_comment')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 10
  end

  scenario 'edits an existing progress' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9

    #======= Edit an existing Progress =======
    find('#progresses > table > tbody > tr:nth-child(1) > td > a.edit-progress').click
    progress_form = ProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_score: 100,
      progress_comment: "test_comment"
    }
    progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('100')
    expect(page).to have_content('test_comment')
    expect(page).to have_no_content('2020-04-01')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9
  end

  scenario 'deletes an existing progress' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9

    #======= Delete an existing Progress =======
    find('#progresses > table > tbody > tr:nth-child(1) > td > a.delete-progress').click
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 8
  end

  scenario 'uploades new progresses' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 9

    #======= Create a new Progress =======
    find('#upload-progress').click
    attach_file('file', 'public/sample/nurture_progress_sample.csv')
    click_on('Import')
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('2022-07-01')
    expect(page).to have_content('2022-08-01')
    expect(page).to have_content('100')
    expect(page).to have_content('test')
    expect(page.all('#progresses >table > tbody > tr').count).to eq 12
  end

  scenario 'exports an existing progress' do
    #======= Login with Tutor ID =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')

    #======= Create a new Progress =======
    find('#download-progress').click
    expect(page).to have_content('Backhand Stroke (%)')
  end
end
