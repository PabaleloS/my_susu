class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # Instance a new Deposit object associated with the current user and susu group
    @deposit = current_user.deposits.new(susu: @susu)
  end

  def create
    # Instance of a new Deposit object with parameters from the form, setting susu and user associations
    @deposit = current_user.deposits.new(deposit_params.merge(susu: @susu, user: current_user))
    if @deposit.save
      # Increase the balance of the susu group by the deposited amount
      @susu.balance += @deposit.amount
      @susu.save!
      redirect_to root_path, notice: "Deposit was successfully created."
    else
      render :new
    end
  end

    private

    def deposit_params
      params.require(:deposit).permit(:amount)
    end

end
