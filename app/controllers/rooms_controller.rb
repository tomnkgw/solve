class RoomsController < ApplicationController
  def index
    requests = current_user.requests
    proposals = current_user.proposals
    @rooms = Room.where(request: requests).or(Room.where(proposal: proposals)).order(latest_message_created_at: :desc)
  end
  
  def create
    request = current_user.requests.find(params[:request_id])
    proposal = request.proposals.find(params[:proposal_id])
    
    request.rooms.find_or_create_by(proposal: proposal)
    redirect_to rooms_path
  end
end
