class ChatForm
  include Capybara::DSL

  def fill_in_with(params = {})
    fill_in('message_content', with: params.fetch(:message_content, "test_message"))
    self
  end

  def submit
    find('input.send').click
    # click_on('Send')
    self
  end
end
