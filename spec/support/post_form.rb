class PostForm
  include Capybara::DSL

  def visit_page
    visit('/en/posts/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('post_title', with: params.fetch(:post_title, "test_title"))
    fill_in('post_content', with: params.fetch(:post_content, "test_content_01234567890123456789"))
    self
  end

  def submit
    click_button('Create Post')
    self
  end
end
