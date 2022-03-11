require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "should get general_contact" do
    get static_pages_general_contact_url
    assert_response :success
  end

  test "should get information" do
    get static_pages_information_url
    assert_response :success
  end
end
