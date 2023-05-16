require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_pages_index_url
    assert_response :success
  end

  test "should get secre" do
    get static_pages_secre_url
    assert_response :success
  end
end
