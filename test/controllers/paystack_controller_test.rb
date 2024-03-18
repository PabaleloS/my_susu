require "test_helper"

class PaystackControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get paystack_callback_url
    assert_response :success
  end

  test "should get webhook" do
    get paystack_webhook_url
    assert_response :success
  end
end
