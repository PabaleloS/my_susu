class SususController < ApplicationController
  def index
    @susus = Susu.all
  end

  def show
    @susu = Susu.find(params[:id])
  end

  def new
    @susus = Susu.new
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

    if @susu.save
      redirect_to @susu, notice: 'Susu was successfully created.'
    else
      render :new
    end
  end

  private

  def susu_params
    params.require(:susu).permit(:name, :description)
  end
end
