require "test_helper"

class DogControllerTest < ActionDispatch::IntegrationTest
  test "should get boys" do
    get dog_boys_url
    assert_response :success
  end

  test "should get girls" do
    get dog_girls_url
    assert_response :success
  end

  test "should get retired" do
    get dog_retired_url
    assert_response :success
  end
end
