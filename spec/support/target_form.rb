class TargetForm
  include Capybara::DSL

  def fill_in_with(params = {})
    fill_in('target_name', with: params.fetch(:target_name, "test_name"))
    select(params.fetch(:target_parent_id, ""), from: 'target_parent_id')
    fill_in('target_description', with: params.fetch(:target_description, "test_description"))
    fill_in('target_score', with: params.fetch(:target_score, "100"))

    if params.fetch(:target_display, true)
      check('target_display')
    else
      uncheck('target_display')
    end
    self
  end

  def submit
    click_button('Save')
    self
  end
end
