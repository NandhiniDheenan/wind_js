require 'test_helper'

class CusloginControllerTest < ActionDispatch::IntegrationTest
  test "should get cusloginview" do
    get cuslogin_cusloginview_url
    assert_response :success
  end

end
