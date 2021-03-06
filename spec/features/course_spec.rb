require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/course_form'

feature 'course' do
  scenario 'creates a new course' do
    #======= Access to course menu =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('courses-menu')
    expect(page).to have_content('Course')
    expect(page).to have_no_content('test_name')
    expect(page).to have_no_content('shingo')
    expect(page.all('div.row > div').count).to eq 3

    #======= Create a new course =======
    course_form = CourseForm.new
    course_params = {
      course_name: "test_name",
      course_description: "test_description",
      course_student_user_id: "shingo"
    }
    course_form.visit_page.fill_in_new_with(course_params).submit
    expect(page).to have_content('Course')
    expect(page).to have_content('test_name')
    expect(page).to have_content('shingo')
    expect(page.all('div.row > div').count).to eq 4

    #======= Logout =======
    session_form.logout

    #======= Log in with Demo Student =======
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    expect(page).to have_content('test_name')

    #======= Accept the new course =======
    click_on("Accept now")
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_description')
    expect(page).to have_content('demo-tutor@nurture.pw')
    click_on("Save")
    expect(page).to have_content('test_name')
  end

  scenario 'edits an existing course' do
    #======= Access to course menu =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('courses-menu')
    expect(page).to have_content('Course')
    expect(page).to have_no_content('test_name')
    expect(page.all('div.row > div').count).to eq 3

    #======= Edits an existing course =======
    find('div.row > div:nth-child(1) div.card > div.card-body a.edit-course').click
    course_form = CourseForm.new
    course_params = {
      course_name: "test_name",
      course_description: "test_description"
    }
    course_form.fill_in_edit_with(course_params).submit
    expect(page).to have_content('Course')
    expect(page).to have_content('test_name')
    expect(page.all('div.row > div').count).to eq 3
  end

  scenario 'deletes an existing course' do
    #======= Access to course menu =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('courses-menu')
    expect(page).to have_content('Course')
    expect(page.all('div.row > div').count).to eq 3

    #======= Deletes an existing course =======
    find('div.row > div:nth-child(1) div.card > div.card-body a.delete-course').click
    expect(page).to have_content('Course')
    expect(page.all('div.row > div').count).to eq 2
  end
end
