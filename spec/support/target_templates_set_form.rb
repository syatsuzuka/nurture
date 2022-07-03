class TargetTemplatesSetForm
  include Capybara::DSL

  def visit_page
    visit('/en/target_templates_sets/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('target_templates_set_name', with: params.fetch(:target_templates_set_name, "test_name"))
    fill_in('target_templates_set_category', with: params.fetch(:target_templates_set_category, "test_category"))

    if params.fetch(:target_templates_set_visible, true)
      check('target_templates_set_visible')
    else
      uncheck('target_templates_set_visible')
    end
    self
  end

  def submit
    click_button('Save')
    self
  end
end
