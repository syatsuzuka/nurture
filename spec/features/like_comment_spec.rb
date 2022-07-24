require 'rails_helper'
require_relative '../support/session_form'
require_relative '../support/post_form'
require_relative '../support/comment_form'

feature 'like/comment' do
  scenario 'like/unlike a post' do

    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')

    #======= Create a new Post =======
    find('#add-post').click
    post_form = PostForm.new
    post_params = {
      post_title: "test_title",
      post_summary: "test_summary",
      post_content: "test_content_01234567890123456789"
    }
    post_form.fill_in_with(post_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_summary')
    expect(page).to have_content('test_content_01234567890123456789')

    #======= Click Like =======
    expect(page).to have_content('0 likes')
    find('input.like-post').click
    expect(page).to have_content('1 likes')
    find('input.unlike-post').click
    expect(page).to have_content('0 likes')
  end

  scenario 'create/delete a new comment' do

    #======= Access to Knowledge list =======
    session_form = SessionForm.new
    session_params = {
      user_email: ENV.fetch('DEMO_TUTOR_LOGIN_ID'),
      user_password: ENV.fetch('DEMO_TUTOR_LOGIN_PASSWORD')
    }
    session_form.visit_page.fill_in_with(session_params).submit
    find('#knowledge-menu').click
    expect(page).to have_content('Knowledge')

    #======= Create a new Post =======
    find('#add-post').click
    post_form = PostForm.new
    post_params = {
      post_title: "test_title",
      post_summary: "test_summary",
      post_content: "test_content_01234567890123456789"
    }
    post_form.fill_in_with(post_params).submit
    expect(page).to have_content('test_title')
    expect(page).to have_content('test_summary')
    expect(page).to have_content('test_content_01234567890123456789')

    #======= Add Comment =======
    comment_form = CommentForm.new
    comment_params = {
      comment_content: "test_comment"
    }
    comment_form.fill_in_with(comment_params).submit
    expect(page).to have_content('test_comment')

    #======= Access to Knowledge list =======
    find('a.delete-comment').click
    expect(page).to have_no_content('test_comment')
  end
end
