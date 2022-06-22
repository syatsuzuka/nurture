require "test_helper"

class LikeCountsControllerTest < ActionDispatch::IntegrationTest
  test "should get add_like" do
    get like_counts_add_like_url
    assert_response :success
  end
end
