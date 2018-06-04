require 'test_helper'

class RegionmapControllerTest < ActionDispatch::IntegrationTest
  test "should get map" do
    get regionmap_map_url
    assert_response :success
  end

end
