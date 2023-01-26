class Public::MessagesController < ApplicationController
  before_action :authenticate_any!
  
  def create
    @message = Message.new(message_params)
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
  
  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

end
