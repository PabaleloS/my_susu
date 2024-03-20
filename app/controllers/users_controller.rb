class UsersController < ApplicationController
  def index
    @susu = Susu.find(params[:susu_id])
    @users = User.where.not(id: @susu.members.pluck(:user_id))

    if params[:query].present?
      @susu = Susu.find(params[:susu_id])
      @users = @users.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: "members/users_list", locals: { users: @users, susu: @susu }, formats: [:html] }
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :photo)
  end
end
