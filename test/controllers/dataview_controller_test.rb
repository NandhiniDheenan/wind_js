require 'test_helper'

class DataviewControllerTest < ActionDispatch::IntegrationTest
  test "should get datatable" do
    get dataview_datatable_url
    assert_response :success
  end

end
