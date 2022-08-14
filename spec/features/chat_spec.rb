require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/assignment_form'
require_relative '../support/chat_form'

feature 'chat' do
  scenario 'creates a new message' do
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

    #======= Send message in chat =======
    find('#chat-link').click
    expect(page).to have_selector('input.send')
    chat_form = ChatForm.new
    chat_params = {
      message_content: "test_message"
    }
    chat_form.fill_in_with(chat_params).submit

    #======= Re-access to chat with Student account =======
    # the test can't be passed unless we reopen the modal page
    session_form.visit_page.logout
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit.visit_page
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    find('#chat-link').click
    expect(page).to have_text('test_message')
    chat_params = {
      message_content: "https://youtu.be/P1mv-weRuTQ"
    }
    chat_form.fill_in_with(chat_params).submit

    #======= Re-access to chat with Tutor account =======
    session_form.visit_page.logout
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit.visit_page
    click_on('courses-menu')
    click_on('Tennis Lesson (Beginner)')
    find('#chat-link').click
    expect(page).to have_text('test_message')
  end
end
