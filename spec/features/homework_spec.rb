require 'rails_helper'
require_relative '../support/new_session_form'

feature 'homework' do
  scenario 'accesses to homework menu' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Homework')
    expect(page).to have_content('All Homeworks')
  end
end
