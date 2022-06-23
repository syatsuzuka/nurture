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
    click_on('Tennis Lesson (Intermediate)')
    click_on('Return Ace Rate (%)')
    expect(page).to have_content('Return Ace Rate (%)')

    #======= Create a new Progress =======
    find('#add-progress').click
    new_progress_form = NewProgressForm.new
    progress_params = {
      progress_date: "2022-06-01",
      progress_scope: 100,
      progress_comment: "test_comment"
    }
    new_progress_form.fill_in_with(progress_params).submit
    expect(page).to have_content('test_comment')
  end
end
