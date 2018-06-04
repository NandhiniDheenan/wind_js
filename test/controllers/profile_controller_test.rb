require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get showprofile" do
    get profile_showprofile_url
    assert_response :success
  end

end
