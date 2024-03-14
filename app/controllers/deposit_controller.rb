class DepositsController < ApplicationController
  before_action :authenticate_user!

  # commented out because the form will come from the popup modal in the susus#show
  # def new
  #   @susu = Susu.find(params[:susu_id])
  #   @deposit = Deposit.new
  # end

  # this should be in the susu controller so member can see their deposits
  # def show
  #   @susu = Susu.find(params[:id])
  #   @deposits = @susu.deposits.includes(:user)
  # end

  def create
    @susu = Susu.find(params[:susu_id])
    # @deposit = @susu.deposits.new(deposit_params)
    @deposit = Deposit.new(deposit_params)
    member = Member.find_by(susu: @susu, user: current_user)
    @deposit.member = member
    @deposit.susu = @susu
    @deposit.date = Date.today

    if @deposit.save
      redirect_to susu_path(@susu), notice: "Deposit was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:agree_amount)
  end
end
