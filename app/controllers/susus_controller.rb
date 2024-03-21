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
    @pending_members = @susu.members.where(status: "accepted")
    # @pending_members = @susu.members.where(status: "pending")
  end

  def new
    @new_susu = Susu.new
    @user = current_user
  end

  def disburse
    susu = Susu.find(params[:id])
    member = susu.next_member

    # Update balances
    ActiveRecord::Base.transaction do
      member.update(balance: member.balance + susu.balance)
      puts "Member balance after update: #{member.balance}" # Debug output
      member.user.update(balance: member.user.balance + susu.balance)
      puts "User balance after update: #{member.user.balance}" # Debug output

      # Reset Susu balance
      susu.update(balance: 0)

      # Redirect with notice
      redirect_to susu_path(susu), notice: "#{susu.agree_amount} disbursed to #{member.user.first_name}. #{member.user.first_name}'s new balance is #{member.user.balance}."
    rescue ActiveRecord::RecordInvalid => e
      # Handle transaction failure
      flash.now[:alert] = "Disbursement unsuccessful, please try again. Error: #{e.message}"
      render :show
    end
  end
  # def disburse
  #   susu = Susu.find(params[:id])
  #   member = susu.next_member
  #   member.balance += susu.balance
  #   member.user.balance += member.balance
  #   member.save

  #   member.user.save

  #   susu.balance = 0

  #   if susu.save && member.save && member.user.save
  #     redirect_to susu_path(susu), notice: "#{susu.agree_amount} disbursed to #{member.user.first_name}"
  #     flash.now[:alert] = "#{member.user.first_name}'s new balance is #{member.user.balance}"
  #   else
  #     render :show, alert: "Disbursement unsuccessful, please try again"
  #   end
  # end

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
