require 'test_helper'

class CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get customerDetails" do
    get customer_customerDetails_url
    assert_response :success
  end

end
