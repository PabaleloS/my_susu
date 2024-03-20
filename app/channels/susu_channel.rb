class SusuChannel < ApplicationCable::Channel
  def subscribed
      susu = Susu.find(params[:id])
      stream_for susu
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
