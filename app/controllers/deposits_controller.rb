class DepositsController < ApplicationController
  before_action :authenticate_user!

  # commented out because the form will come from the popup modal in the susus#show
  def new
    puts "Params: #{params.inspect}"
    @susu = Susu.find(params[:susu_id])
    puts "@susu: #{@susu.inspect}"
    @agreed_amount = @susu.agree_amount
    @deposit = Deposit.new
    @susu.balance ||= 0
  end

  # this should be in the susu controller so member can see their deposits
  def show
    @deposit = Deposit.find(params[:id])
    # @deposits = @susu.deposits.includes(:user)

  end

  def create
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
    #   redirect_to susu_deposits_url(@susu, @deposit), notice: "Deposit was successfully added."
    else
      render :new
    end
  end






  # def create
  #   @susu = Susu.find(params[:susu_id])
  #   # @deposit = @susu.deposits.new(deposit_params)
  #   # @deposit = Deposit.new(deposit_params)
  #   @deposit = @susu.deposits.new(deposit_params)
  #   member = @susu.members.find_by(user_id: current_user.id)
  #   # member = Member.find_by(susu: @susu, user_id: current_user.id)
  #   @deposit.member = member
  #   # @deposit.susu = @susu
  #   @deposit.date = Date.today
  #   @susu.balance += @deposit.agree_amount
  #   if @deposit.save! && @susu.save!
  #     redirect_to susu_deposit_path(@susu, @deposit), notice: "Deposit was successfully added."
  #   end
  # end

  private

  def deposit_params
    params.require(:deposit).permit(:agree_amount)
  end
end
