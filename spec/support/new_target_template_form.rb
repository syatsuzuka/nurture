class NewTargetTemplateForm
  include Capybara::DSL

  def visit_page
    visit('/target_template/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('target_template_name', with: params.fetch(:target_template_name, "test_name"))
    select(params.fetch(:target_template_parent_id, ""), from: 'target_template_parent_id')
    fill_in('target_template_description', with: params.fetch(:target_template_description, "test_description"))
    fill_in('target_template_score', with: params.fetch(:target_template_score, "test_score"))
    self
  end

  def submit
    click_button('Save')
    self
  end
end
