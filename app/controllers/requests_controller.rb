class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @proposals = Proposal.all
  end

  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    @request.save
    redirect_to requests_path
  end

  def edit
    @request = Request.find(params[:id])
  end
  
  def update
    @request = Request.find(params[:id])
    @request.update(request_params)
    redirect_to requests_path
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_path
  end
  
  private
  def request_params
    params.require(:request).permit(:title, :budget, :text)
  end
end
