class AssignmentTemplatesSetForm
  include Capybara::DSL

  def visit_page
    visit('/en/assignment_templates_sets/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('assignment_templates_set_name', with: params.fetch(:assignment_templates_set_name, "test_name"))
    fill_in(
      'assignment_templates_set_category',
      with: params.fetch(:assignment_templates_set_category, "test_category")
    )

    if params.fetch(:assignment_templates_set_visible, true)
      check('assignment_templates_set_visible')
    else
      uncheck('assignment_templates_set_visible')
    end
    self
  end

  def submit
    click_button('Save')
    self
  end
end
