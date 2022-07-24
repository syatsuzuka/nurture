class CommentForm
  include Capybara::DSL

  def fill_in_with(params = {})
    fill_in('comment_content', with: params.fetch(:comment_content, "test_comment"))
    self
  end

  def submit
    find('#save').click
    self
  end
end
