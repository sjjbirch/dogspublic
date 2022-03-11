require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get tools" do
    get dashboard_tools_url
    assert_response :success
  end
end
