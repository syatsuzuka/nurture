require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_progress_form'

feature 'progress' do
  scenario 'creates a new progress' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('Courses')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')

    #======= Create a new Progress =======
    find('#add-progress').click
    new_progress_form = NewProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_score: 100,
      progress_comment: "test_comment"
    }
    new_progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('test_comment')
  end

  scenario 'edits an existing progress' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('Courses')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')

    #======= Create a new Progress =======
    find('#progresses > table > tbody > tr:nth-child(1) > td > a.edit-progress').click
    new_progress_form = NewProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_score: 100,
      progress_comment: "test_comment"
    }
    new_progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('100')
    expect(page).to have_content('test_comment')
    expect(page).to have_no_content('2020-04-01')
  end

  scenario 'uploades new progresses' do
    #======= Login with Tutor ID =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit

    #======= Access to Target detail =======
    click_on('Courses')
    click_on('Tennis Lesson (Beginner)')
    click_on('Backhand Stroke (%)')
    expect(page).to have_content('Backhand Stroke (%)')

    #======= Create a new Progress =======
    find('#upload-progress').click
    attach_file('file', 'public/sample/nurture_progress_sample.csv')
    click_on('Import')
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('2022-06-01')
    expect(page).to have_content('100')
    expect(page).to have_content('test')
  end
end
