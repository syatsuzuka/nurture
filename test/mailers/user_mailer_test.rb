# require "test_helper"

# class UserMailerTest < ActionMailer::TestCase
#   test "welcome_email" do
#     # Create the email and store it for further assertions
#     email = UserMailer.create_welcome_email("oshtemo@playfunplus.com", , Time.now)
#     # Send the email, then test that it got queued
#     assert_emails 1 do
#       email.deliver_now
#     end
#     # Test the body of the sent email contains what we expect it to
#     assert_equal ["oshtemo@playfunplus.com"], email.from
#     assert_equal @user.email, email.to
#     assert_equal "Your Nurture account is now registered", email.subject
#     assert_equal read_fixture("created").join, email.text_part.body.to_s
#   end
# end
