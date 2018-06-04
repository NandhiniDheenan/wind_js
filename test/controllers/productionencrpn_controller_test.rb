require 'test_helper'

class ProductionencrpnControllerTest < ActionDispatch::IntegrationTest
  test "should get encrpnhome" do
    get productionencrpn_encrpnhome_url
    assert_response :success
  end

end
