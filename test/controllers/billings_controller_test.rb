require 'test_helper'

class BillingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get billings_index_url
    assert_response :success
  end

  test "should get create" do
    get billings_create_url
    assert_response :success
  end

  test "should get destroy" do
    get billings_destroy_url
    assert_response :success
  end

  test "should get pre_pay" do
    get billings_pre_pay_url
    assert_response :success
  end

  test "should get execute" do
    get billings_execute_url
    assert_response :success
  end

end
