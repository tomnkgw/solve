class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = params[:room_id]
    @message.save
    redirect_to room_path(params[:room_id])
  end
  
  private
  def message_params
    params.require(:message).permit(:text)
  end
end
