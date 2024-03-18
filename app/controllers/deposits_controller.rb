

class DepositsController < ApplicationController
  before_action :authenticate_user!

  def new
    puts "Params: #{params.inspect}"
    @susu = Susu.find(params[:susu_id])
    puts "@susu: #{@susu.inspect}"
    @agreed_amount = @susu.agree_amount
    @deposit = Deposit.new
    @susu.balance ||= 0
  end

  def show
    @deposit = Deposit.find(params[:id])
    # @deposits = @susu.deposits.includes(:user)
  end

  def create
    @current_user = current_user
    @susu = Susu.find(params[:susu_id])
    @deposit = @susu.deposits.new(deposit_params)
    member = @susu.members.find_by(user_id: current_user.id)

    if member.nil?
      redirect_to root_path, alert: "You are not a member of this SUSU."
      return
    end

    @deposit.member = member
    @deposit.date = Date.today
    @susu.balance ||= 0
    @susu.balance += @deposit.agree_amount

    if @deposit.save && @susu.save
      redirect_to deposit_path(@susu, @deposit), notice: "Deposit was successfully added."
      render json: { status: 'success' }
    else
      render :new
      render json: { status: 'error', errors: @deposit.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def deposit_params
    params.require(:deposit).permit(:agree_amount)
  end
end
