require 'test_helper'

class PowercurveControllerTest < ActionDispatch::IntegrationTest
  test "should get powershow" do
    get powercurve_powershow_url
    assert_response :success
  end

end
