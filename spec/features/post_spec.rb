require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/post_form'

feature 'post' do
  scenario 'Create a new Post' do
    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1

    #======= Create a new Post =======
    click_on('New Post')
    post_form = PostForm.new
    post_params = { post_title: "test_title", post_content: "test_content_01234567890123456789" }
    post_form.fill_in_with(post_params).submit

    #======= Access to Knowledge list =======
    # find('#knowledge-menu').click
    # expect(page).to have_content('Knowledge')
    # expect(page).to have_content('test_title')
    # expect(page.all('div.card').count).to eq 2
  end

  scenario 'Edit an existing Knowledge' do
    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = { user_email: ENV['DEMO_TUTOR_LOGIN_ID'], user_password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'] }
    session_form.visit_page.fill_in_with(session_params).submit
    click_on('knowledge-menu')
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1

    #======= Edit an existing Post =======
    # find('div.card:nth-child(1) div.card-body a.btn-success').click
    # post_form = PostForm.new
    # post_params = { post_title: "test_title", post_content: "test_content_01234567890123456789" }
    # post_form.fill_in_with(post_params).submit
    # expect(page).to have_content('test_title')

    #======= Access to Knowledge list =======
    # click_on('knowledge-menu')
    # expect(page).to have_content('Knowledge')
    # expect(page.all('div.card').count).to eq 2
  end
end
