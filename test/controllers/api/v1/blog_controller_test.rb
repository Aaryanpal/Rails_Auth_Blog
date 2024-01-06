require "test_helper"

class Api::V1::BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_blog_index_url
    assert_response :success
  end
end
