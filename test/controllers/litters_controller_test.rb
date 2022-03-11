require "test_helper"

class LittersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get litters_create_url
    assert_response :success
  end

  test "should get update" do
    get litters_update_url
    assert_response :success
  end

  test "should get delete" do
    get litters_delete_url
    assert_response :success
  end

  test "should get schedule" do
    get litters_schedule_url
    assert_response :success
  end

  test "should get gallery" do
    get litters_gallery_url
    assert_response :success
  end
end
