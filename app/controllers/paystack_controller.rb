# app/controllers/paystack_controller.rb
class PaystackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def callback
    render json: { message: 'Test Callback URL received successfully' }
  end

  def webhook
    head :ok
  end
end
