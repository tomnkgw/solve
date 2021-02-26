class MessagesController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @message = Message.new(message_params)
      @message.user_id = current_user.id
      @message.room_id = params[:room_id]
      @message.save
      room = @message.room
      room.latest_message_created_at = Time.current
      room.save
    end
    redirect_to room_path(params[:room_id])
  end
  
  private
  def message_params
    params.require(:message).permit(:text)
  end
end
