require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/post_form'

feature 'post' do
  scenario 'Create a new Post' do
    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1

    #======= Create a new Post =======
    find('#add-post').click
    post_form = PostForm.new
    post_params = { post_title: "test_title", post_summary: "test_summary", post_content: "test_content_01234567890123456789" }
    post_form.fill_in_with(post_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_summary')
    expect(page).to have_content('test_content_01234567890123456789')

    #======= Access to Knowledge list =======
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_summary')
    expect(page.all('div.card').count).to eq 2
  end

  scenario 'Edit an existing Knowledge' do
    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1

    #======= Edit an existing Post =======
    find('div.row > div:nth-child(1) > div.card > div.card-body > a.edit-post').click
    post_form = PostForm.new
    post_params = { post_title: "test_title", post_summary: "test_summary", post_content: "test_content_01234567890123456789" }
    post_form.fill_in_with(post_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_summary')

    #======= Access to Knowledge list =======
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1
  end

  scenario 'Delete an existing Knowledge' do
    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_STUDENT_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_STUDENT_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 1

    #======= Edit an existing Post =======
    find('div.row > div:nth-child(1) > div.card > div.card-body > a.delete-post').click

    #======= Access to Knowledge list =======
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')
    expect(page.all('div.card').count).to eq 0
  end
end
