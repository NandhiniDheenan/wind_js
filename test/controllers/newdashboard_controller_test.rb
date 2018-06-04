require 'test_helper'

class NewdashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboardshow" do
    get newdashboard_dashboardshow_url
    assert_response :success
  end

end
