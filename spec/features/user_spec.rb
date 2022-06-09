require 'rails_helper'
require_relative '../support/new_user_form'
require_relative '../support/new_session_form'
require_relative '../support/navbar'

feature 'create new user' do
  scenario 'create new user with valid data' do
    new_user_form = NewUserForm.new
    new_user_form.visit_page.fill_in_with.submit
    expect(page).to have_content('Dashboard')
  end
end

feature 'login' do
  scenario 'login with an user' do
    new_session_form = NewSessionForm.new
    new_session_form.visit_page.fill_in_with.submit
    expect(page).to have_content('Dashboard')
  end
end
