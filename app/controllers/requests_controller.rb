class RequestsController < ApplicationController
  before_action :set_q, only: [:index, :search]
  
  def index
    @requests = Request.all
    @requests = Request.page(params[:page]).order(id: "DESC").per(8)
  end

  def show
    @request = Request.find(params[:id])    
    @proposal = @request.proposals.find_by(user: current_user)
  end

  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    @request.status = 'requesting'
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
  
  def search
    @requests = Request.all
    @results = @q.result
  end
  
  private
  
  def set_q
    @q = Request.ransack(params[:q])
  end
  
  def request_params
    params.require(:request).permit(:title, :budget, :text)
  end
  
end
