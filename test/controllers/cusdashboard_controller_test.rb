require 'test_helper'

class CusdashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get cusdashboardview" do
    get cusdashboard_cusdashboardview_url
    assert_response :success
  end

end
