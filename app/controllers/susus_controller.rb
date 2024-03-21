class SususController < ApplicationController
  before_action :authenticate_user!

  def index
      @user = current_user
      if params[:id].present?
        @member = Member.find_by(id: params[:id], user_id: current_user.id)
        if @member.nil?
          # Handle the case where the member with the given ID does not belong to the current user
          flash[:alert] = "Member not found."
          redirect_to some_path # Redirect to an appropriate page or handle the error as needed
          return
        end
        @members = [@member] # Assign the found member to the @members instance variable
      else
        @member = nil
        @members = @user.members
      end

      @pending_susus = Susu.joins(:members).where(members: { user_id: current_user, status: 'pending' })
      @accepted_susus = Susu.joins(:members).where(members: { user_id: current_user, status: 'accepted' })
      @declined_susus = Susu.joins(:members).where(members: { user_id: current_user, status: 'declined' })
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
    @new_susu = Susu.new
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
raise
    if @susu.save
      redirect_to new_susu_member_path(@susu), notice: 'Susu was successfully created.'
    else
      render :new
    end
  end

  private

  def susu_params
    params.require(:susu).permit(:name, :agree_amount, :description)
  end

end
