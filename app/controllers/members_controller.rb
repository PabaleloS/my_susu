class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @susu = Susu.find(params[:susu_id])
    # Retrieves members specific to the Susu group being viewed
    @members = @susu.members
    # Fetch the last deposit date and amount for each member
    @last_deposits = {}
    @members.each do |member|
      last_deposit = member.deposits.last
      @last_deposits[member.id] = last_deposit ? { date: last_deposit.created_at.to_date, agree_amount: last_deposit.agree_amount } : nil
    end
  end

  # show detz of a specific member of a susu
  def show
  @susu = Susu.find(params[:id])
  # find the member of the susu
  @member = @susu.members.find(params[:id])
  end

  def new
    @susu = Susu.find(params[:susu_id])
    @users_not_in_susu = User.where.not(id: @susu.members.pluck(:user_id))
  end

  def create
    @susu = Susu.find(params[:susu_id])
    # Instance of a new Member object with parameters from the form, setting susu and user associations
    @member = @susu.members.new(member_params)
    @member.user = current_user
    if @member.save
      redirect_to @susu, notice: "Member was successfully added."
    else
      render :new
    end
  end

  def create_members
    @user_ids = params[:member_ids]
    @susu = Susu.find(params[:id])
    @user_ids.each do |user_id|
      member = Member.new(user_id: user_id,
                          susu_id: @susu.id,
                          status: "pending",
                          balance: 0,
                          join_date: Date.today)
    member.save
    end
    redirect_to root_path, notice: "Members were successfully added."
  end

  def accepted
    member = Member.find_by(susu_id: params[:susu_id], user_id: params[:user_id])
    if member
      member.update(status: "accepted")
      redirect_to susu_path(params[:susu_id]), notice: "Member accepted ."
    else
      redirect_to susu_path(params[:susu_id]), notice: "Member not found."
    end
  end

  # def declined
  #   member = Member.find_by(susu_id: params[:susu_id], user_id: params[:user_id])
  #   if member
  #     member.update(status: "declined")
  #     redirect_to susu_path(params[:susu_id]), notice: "Member declined ."
  #   else
  #     redirect_to susu_path(params[:susu_id]), notice: "Member not found."
  #   end
  # end

  def update
    @member = current_user.member.find_by(susu_id: params[:susu_id])

    if params[:commit] == 'Accept'
      @member.update(status: 'accepted')
      redirect_to susu_path(@member.susu_id), notice: 'Invitation accepted successfully.'
    elsif params[:commit] == 'Decline'
      @member.update(status: 'declined')
      if @member.update.susu.status == 'declined'
        @member.destroy
        redirect_to susu_path(@member.susu_id), notice: 'Invitation declined and deleted.'
      else
      redirect_to susu_path(@member.susu_id), notice: 'Invitation declined successfully.'
      end
    end
  end

  private
  def member_params
    params.require(:member).permit(:user_id)
  end
end
