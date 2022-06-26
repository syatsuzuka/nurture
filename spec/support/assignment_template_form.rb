class AssignmentTemplateForm
  include Capybara::DSL

  def fill_in_with(params = {})
    fill_in('assignment_template_title', with: params.fetch(:assignment_template_title, "test_title"))
    fill_in('assignment_template_instruction', with: params.fetch(:assignment_template_instruction, "test_instruction"))
    fill_in('assignment_template_instruction_url', with: params.fetch(:assignment_template_instruction_url, "https://www.nurture.pw"))
    fill_in('assignment_template_checkpoint', with: params.fetch(:assignment_template_checkpoint, "test_checkpoint"))
    self
  end

  def submit
    click_button('Save')
    self
  end
end
