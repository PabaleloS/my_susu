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

def accept
  @member = Member.find(params[:id]) # Assuming you have a Member model
  # Logic to accept a member
  if @member.update(status: 'accepted') # Assuming you have a 'status' attribute in your Member model
    redirect_to members_path, notice: 'Member accepted successfully.'
  else
    redirect_to members_path, alert: 'Failed to accept member.'
  end
end

def decline
  @member = Member.find(params[:id]) # Assuming you have a Member model
  # Logic to decline a member
  if @member.update(status: 'declined') # Assuming you have a 'status' attribute in your Member model
    redirect_to members_path, notice: 'Member declined successfully.'
  else
    redirect_to members_path, alert: 'Failed to decline member.'
  end
end
end   

  def message_params
    params.require(:message).permit(:content)
  end
