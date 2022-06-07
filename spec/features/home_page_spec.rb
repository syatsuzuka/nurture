require 'rails_helper'

feature 'landing page' do
  scenario 'welcome message' do
    visit('/')
    expect(page).to have_content('Start learning')
  end
end
