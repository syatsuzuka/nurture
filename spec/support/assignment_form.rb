class AssignmentForm
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

  def fill_in_with2(params = {})
    fill_in('assignment_title', with: params.fetch(:assignment_title, "test_title"))
    fill_in('assignment_instruction', with: params.fetch(:assignment_instruction, "test_instruction"))
    fill_in('assignment_instruction_url', with: params.fetch(:assignment_instruction_url, "https://www.nurture.pw"))
    fill_in('assignment_checkpoint', with: params.fetch(:assignment_checkpoint, "test_checkpoint"))
    select(params.fetch(:assignment_status, "Work In Process"), from: 'assignment_status')
    fill_in('assignment_comment', with: params.fetch(:assignment_comment, "test_comment"))
    fill_in('assignment_material_url', with: params.fetch(:assignment_material_url, "https://www.nurture.pw"))
    fill_in('assignment_review_comment', with: params.fetch(:assignment_review_comment, "test_review_comment"))
    find('#assignment_start_date').set(params.fetch(:assignment_start_date, "2022-01-01"))
    find('#assignment_end_date').set(params.fetch(:assignment_end_date, "2022-12-31"))
    self
  end

  def fill_in_with3(params = {})
    select(params.fetch(:assignment_status, "Done"), from: 'assignment_status')
    fill_in('assignment_comment', with: params.fetch(:assignment_comment, "test_comment"))
    fill_in('assignment_material_url', with: params.fetch(:assignment_material_url, "https://www.nurture.pw"))
    find('#assignment_start_date').set(params.fetch(:assignment_start_date, "2022-01-01"))
    find('#assignment_end_date').set(params.fetch(:assignment_end_date, "2022-12-31"))
    self
  end

  def submit
    click_button('Save')
    self
  end
end
