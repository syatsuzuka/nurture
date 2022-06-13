require 'rails_helper'
require_relative '../support/new_session_form'

feature 'target' do
  scenario 'accesses to target detail' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Courses')
    click_on('Tennis Lesson (Intermediate)')
    click_on('/ Return Ace Rate (%)')
    expect(page).to have_content('Return Ace Rate (%)')
  end
end
