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
      
      room.messages.create!(
        user: current_user,
        text: "<span style='font-weight: bold;'>#{params['proposal']['last_budget']}</span> 円で確定依頼が来ました　確認してください",
        display_type: 'confirm_request',
      )
    end
    
    redirect_to room_path(room)
  end
  
  def confirm
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.confirm!
    
    request = @proposal.request
    request.confirm!
    
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
    
    @proposal.request.requesting!
    
    room = @proposal.room
    room.messages.create!(
      user: current_user,
      text: '確定依頼を差し戻しました'
      )
      
     redirect_to room_path(room)
  end
  
  private
  def proposal_params
    params.require(:proposal).permit(:text, :budget)
  end
end
