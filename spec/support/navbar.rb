class Navbar
  include Capybara::DSL

  def visit_page
    visit('/')
    self
  end

  def logout
    click_on('Log out')
    self
  end
end
