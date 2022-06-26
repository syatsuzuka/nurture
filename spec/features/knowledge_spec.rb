require 'rails_helper'
require_relative '../support/session_form'

feature 'knowledge' do
  scenario 'accesses to knowledge menu' do
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('Knowledge')
    expect(page).to have_content('Knowledge')
  end
end
