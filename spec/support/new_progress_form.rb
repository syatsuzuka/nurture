class NewProgressForm
  include Capybara::DSL

  def fill_in_with(params = {})
    find('#progress_date').set(params.fetch(:progress_date, "2022-06-01"))
    fill_in('progress_score', with: params.fetch(:progress_score, 30))
    fill_in('progress_comment', with: params.fetch(:progress_comment, "test_comment"))
    self
  end

  def submit
    click_button('Save')
    self
  end
end
