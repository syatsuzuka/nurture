require 'rails_helper'
require_relative '../support/new_user_form'

feature 'create new user' do
  scenario 'create new user with valid data' do
    new_user_form = NewUserForm.new
    new_user_form.visit_page.fill_in_with.submit
    expect(page).to have_content('Dashboard')
  end
end
