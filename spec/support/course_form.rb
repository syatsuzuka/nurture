class CourseForm
  include Capybara::DSL

  def visit_page
    visit('/courses/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('course_name', with: params.fetch(:course_name, "test_name"))
    fill_in('course_description', with: params.fetch(:course_description, "test_description"))
    select(params.fetch(:course_student_user_id, "Sample Student"), from: 'course_student_user_id')
    self
  end

  def submit
    click_button('Save')
    self
  end
end
