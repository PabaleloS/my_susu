class SususController < ApplicationController
  def index
    @susus = Susu.all
    @user = current_user
  end

  def show
    @susu = Susu.find(params[:id])
    @user = current_user
    @message = Message.new
  end

  def new
    @susu = Susu.new
    @user = current_user
  end

  def disburse
    susu = Susu.find(params[:id])
    member = @susu.next_member
    member.balance += susu.balance
    member.save
    susu.balance = 0
    susu.save
  end

  def create
    @susu = Susu.new(susu_params)
    @susu.user_id = current_user.id

    if @susu.save
      redirect_to susu_members_path(@susu), notice: 'Susu was successfully created.'

    else
      render :new
    end
  end

  private

  def susu_params
    params.require(:susu).permit(:name, :agree_amount, :description)
  end

end
