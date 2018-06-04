require 'test_helper'

class HelpdeskControllerTest < ActionDispatch::IntegrationTest
  test "should get helpdeskshow" do
    get helpdesk_helpdeskshow_url
    assert_response :success
  end

end
