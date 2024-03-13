class MessagesController < ApplicationController
  def index
    @susu = Susu.find(params[:susu_id])
    @messages = @susu.messages
    @message = Message.new
  end

  def create
    @susu = Susu.find(params[:susu_id])
    @message = Message.new(message_params)
    @message.susu = @susu
    @message.member = Member.find_by(user: current_user, susu: @susu)
    if @message.save
      redirect_to susu_messages_path(@susu)
    else
      render "susus/show", status: :unprocessable_entity
    end
  end

private

  def message_params
    params.require(:message).permit(:content)
  end
end
