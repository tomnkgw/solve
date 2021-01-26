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
  
  private
  def proposal_params
    params.require(:proposal).permit(:text, :budget)
  end
end
