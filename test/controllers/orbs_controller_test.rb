require 'test_helper'

class OrbsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orbs_index_url
    assert_response :success
  end

end
