class NewAssignmentForm
  include Capybara::DSL

  def fill_in_with(params = {})
    fill_in('assignment_title', with: params.fetch(:assignment_title, "test_title"))
    fill_in('assignment_instruction', with: params.fetch(:assignment_instruction, "test_instruction"))
    fill_in('assignment_instruction_url', with: params.fetch(:assignment_instruction_url, "https://www.nurture.pw"))
    fill_in('assignment_checkpoint', with: params.fetch(:assignment_checkpoint, "test_checkpoint"))
    find('#assignment_start_date').set(params.fetch(:assignment_start_date, "2022-01-01"))
    find('#assignment_end_date').set(params.fetch(:assignment_end_date, "2022-12-31"))
    self
  end

  def submit
    click_button('Save')
    self
  end
end
