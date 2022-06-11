require 'rails_helper'
require_relative '../support/new_session_form'

feature 'student' do
  scenario 'accesses to student menu' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Students')
    expect(page).to have_content('Student List')
  end
end
