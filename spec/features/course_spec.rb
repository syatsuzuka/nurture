require 'rails_helper'
require_relative '../support/new_session_form'
require_relative '../support/new_course_form'
require_relative '../support/navbar'

feature 'course' do
  scenario 'creates a new course' do
    #======= Access to course menu =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit
    click_on('Courses')
    expect(page).to have_content('Course List')

    #======= Create a new course =======
    new_course_form = NewCourseForm.new
    course_params = {
      course_name: "test_name",
      course_description: "test_description",
      course_student_user_id: "shingo"
    }
    new_course_form.visit_page.fill_in_with(course_params).submit
    expect(page).to have_content('Course List')

    click_on('Courses')
    expect(page).to have_content('test_name')
    expect(page).to have_content('shingo')

    #======= Logout =======
    navbar = Navbar.new
    navbar.logout

    #======= Log in with Demo Student =======
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_STUDENT_LOGIN_ID'], user_password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit
    expect(page).to have_content('test_name')

    #======= Accept the new course =======
    click_on("Accept now")
    expect(page).to have_content('test_name')
    expect(page).to have_content('test_description')
    expect(page).to have_content('demo-tutor@nurture.pw')
    click_on("Save")
    expect(page).to have_content('test_name')
  end
end
