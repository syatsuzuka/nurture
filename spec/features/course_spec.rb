require 'rails_helper'
require_relative '../support/new_session_form'

feature 'course' do
  scenario 'accesses to course menu' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Courses')
    expect(page).to have_content('Course List')
  end
end
