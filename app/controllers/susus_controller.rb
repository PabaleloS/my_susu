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
    @user = current_user
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

  def accept_invite

    @user = current_user
    @susu = Susu.find(params[:id])
    @member = @susu.members.find_by(user_id: @user.id)

    if @member.update(status: :accepted)
      # raise
      redirect_to susu_path(@susu), notice: "You have accepted the invite to join the Susu"
    else
      redirect_to susus_path, alert: "An error occurred, please try again"
    end
  end

  def create
    @susu = Susu.new(susu_params)
    @susu.user_id = current_user.id

    if @susu.save
      redirect_to  new_susu_member_path(@susu), notice: 'Susu was successfully created.'
    else
      render :new
    end
  end

  private

  def susu_params
    params.require(:susu).permit(:name, :agree_amount, :description)
  end

end
