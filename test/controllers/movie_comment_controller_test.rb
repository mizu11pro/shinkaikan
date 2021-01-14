require 'test_helper'

class MovieCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get movie_comment_create_url
    assert_response :success
  end

  test "should get destroy" do
    get movie_comment_destroy_url
    assert_response :success
  end

end
