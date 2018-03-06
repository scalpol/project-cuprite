require 'test_helper'

class PruebasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pruebas_index_url
    assert_response :success
  end

  test "should get admin" do
    get pruebas_admin_url
    assert_response :success
  end

end
