class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @susu = Susu.find(params[:susu_id])
    # test with line below
    @member = @susu.members.new
    #
    @members = @susu.members
  end

  # show detz of a specific member of a susu
  def show
  @susu = Susu.find(params[:id])
  # find the member of the susu
  @member = @susu.members.find(params[:id])
  end

  def new
    @susu = Susu.find(params[:susu_id])
    @member = @susu.members.new
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

  def accepted
    member = Member.find_by(susu_id: params[:susu_id], user_id: params[:user_id])
    if member
      member.update(status: "accepted")
      redirect_to susu_path(params[:susu_id]), notice: "Member accepted ."
    else
      redirect_to susu_path(params[:susu_id]), notice: "Member not found."
    end
  end

  def declined
    member = Member.find_by(susu_id: params[:susu_id], user_id: params[:user_id])
    if member
      member.update(status: "declined")
      redirect_to susu_path(params[:susu_id]), notice: "Member declined ."
    else
      redirect_to susu_path(params[:susu_id]), notice: "Member not found."
    end
  end

  def update
    @member = current_user.member.find_by(susu_id: params[:susu_id])
  end

  private

  def member_params
    params.require(:member).permit(:user_id)
  end
end
