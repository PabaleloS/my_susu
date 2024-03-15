class SususController < ApplicationController

  def index

      @user = current_user
      @members = @user.members
      # @susus = @members.susus
      @susus = []
      @members.each do |member|
        susu = member.susu
        @member = member
        @susus << susu
      end
  end

  def show
    @susu = Susu.find(params[:id])
    @message = Message.new
    @all_members = @susu.members
    @accepted_members = @susu.members.where(status: "accepted")
    @pending_members = @susu.members.where(status: "pending")
  end

  def new
    @susu = Susu.new
    @user = current_user
  end

  def disburse
    susu = Susu.find(params[:id])
    member = susu.next_member
    member.balance += susu.balance
    member.save
    susu.balance = 0

    if susu.save && member.save
      redirect_to susu_path(susu), notice: "#{susu.agree_amount} disbursed to #{member.user.first_name}"
    else
      render :show, alert: "disbursement unsuccessful, please try again"
    end
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
