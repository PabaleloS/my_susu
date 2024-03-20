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
      SusuChannel.broadcast_to(
        @susu,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.member.user.id
      )
      head :ok
    else
      render "susus/show", status: :unprocessable_entity
    end
  end


    private

    def message_params
      params.require(:message).permit(:content)
    end
  end








