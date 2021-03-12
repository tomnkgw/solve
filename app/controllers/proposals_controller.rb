class ProposalsController < ApplicationController
  def new
    @request = Request.find(params[:request_id])
    @proposal = Proposal.new
  end

  def edit
  end
  
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.request_id = params[:request_id]
    @proposal.user_id = current_user.id
    @proposal.status = 'proposing'
    @proposal.save
    
    @request = @proposal.request
    @request.create_notification_proposal!(current_user, @proposal.id)
    
    redirect_to request_path(params[:request_id])
  end
  
  def confirm_request
    
    @proposal = Proposal.find(params[:proposal_id])
    request = @proposal.request
    room = @proposal.room
    request.with_lock do
      raise unless request.requesting?
      
      @proposal.last_budget = params['proposal']['last_budget']
      @proposal.confirm_request!
      request.confirm_request!
      
      request.create_notification_confirm_request!(current_user, @proposal.user_id)
      
      room.messages.create!(
        user: current_user,
        text: "<span style='font-weight: bold;'>#{params['proposal']['last_budget']}</span> 円で確定依頼が来ました　確認してください",
        display_type: 'confirm_request'
      )
      room.latest_message_created_at = Time.current
      room.save
    end
    
    
    redirect_to room_path(room)
  end
  
  def confirm
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.confirm!
    
    request = @proposal.request
    request.confirm!
    
    message = Message.find(params[:proposal][:message_id])
    message.normal!
    
    @proposal.request.create_notification_confirm!(current_user)
    
    room = @proposal.room
    room.messages.create!(
      user: current_user,
      text: '確定しました'
    )
    
    redirect_to room_path(room)  
  end
  
  def proposing
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.proposing!
    message = Message.find(params[:proposal][:message_id])
    message.normal!
    
    @proposal.request.requesting!
    @proposal.request.create_notification_reject!(current_user)
    
    room = @proposal.room
    room.messages.create!(
      user: current_user,
      text: '確定依頼を差し戻しました',
      )
    room.latest_message_created_at = Time.current
    room.save
     redirect_to room_path(room)
  end
  
  def complete_request
    proposal = Proposal.find(params[:proposal_id])
    proposal.complete_request!
    room = proposal.room
    
    proposal.request.create_notification_complete_request!(current_user)
    room.messages.create!(
      user: current_user,
      text: '依頼内容を完了しました。完了ボタンを押すと相手に報酬が支払われます。',
      display_type: 'complete_request'
    )
    room.latest_message_created_at = Time.current
    room.save
    redirect_to room_path(room)  
  end
  
  def complete
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.complete!
    message = Message.find(params[:proposal][:message_id])
    message.normal!
    
    @proposal.request.create_notification_complete!(current_user, @proposal.user_id)
    
    room = @proposal.room
    room.messages.create!(
      user: current_user,
      text: '取引が完了しました。ありがとうございました！',
    )
    room.latest_message_created_at = Time.current
    room.save
    redirect_to room_path(room)  
  end
  
  private
  def proposal_params
    params.require(:proposal).permit(:text, :budget)
  end
end
