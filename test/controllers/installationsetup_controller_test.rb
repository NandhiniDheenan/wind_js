require 'test_helper'

class InstallationsetupControllerTest < ActionDispatch::IntegrationTest
  test "should get customerinstallation" do
    get installationsetup_customerinstallation_url
    assert_response :success
  end

end
