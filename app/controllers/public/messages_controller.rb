class Public::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    #byebug
    @message.save
    @notification = Notification.new
    @notification.message_id = @message.id
    
    @notification.save
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:messageable_type, :messageable_id, :room_id, :message)
  end

end
