require 'rails_helper'
require_relative '../support/new_session_form'

feature 'knowledge' do
  scenario 'accesses to knowledge menu' do
    new_session_form = NewSessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    new_session_form.visit_page.fill_in_with(session_params).submit
    click_on('Knowledge')
    expect(page).to have_content('Knowledge')
  end
end
