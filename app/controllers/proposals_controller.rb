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
    @proposal.last_budget = params['proposal']['last_budget']
    @proposal.confirm_request!
    
    room = @proposal.room
    room.messages.create!(
      user: current_user,
      text: '金額を確認して、確定してください'
    )
    
    redirect_to room_path(room)
  end
  
  private
  def proposal_params
    params.require(:proposal).permit(:text, :budget)
  end
end
