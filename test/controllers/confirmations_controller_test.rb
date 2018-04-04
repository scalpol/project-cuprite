require 'test_helper'

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get confirmations_create_url
    assert_response :success
  end

end
