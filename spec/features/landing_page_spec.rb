require 'rails_helper'

feature 'landing page' do
  scenario 'accesses to sign in page' do
    visit('/')
    find('#start').click
    expect(page).to have_content('Sign in')
  end
end
