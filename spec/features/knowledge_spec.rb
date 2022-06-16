require 'rails_helper'
require_relative '../support/new_session_form'

feature 'knowledge' do
  scenario 'accesses to knowledge menu' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    click_on('Knowledge')
    expect(page).to have_content('Knowledge')
  end
end
