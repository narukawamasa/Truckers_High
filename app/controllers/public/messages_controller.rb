class Public::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    #byebug
    @message.save!
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:messageable_type, :messageable_id, :room_id, :message)
  end

end
