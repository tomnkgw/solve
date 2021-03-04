class FavoritesController < ApplicationController
 def create 
    @favorite = current_user.favorites.create(request_id: params[:request_id])
    
    @request = Request.find(params[:request_id])
    @request.create_notification_favorite!(current_user)
    
    redirect_back(fallback_location: root_path)
    
 end
 
 def destroy
    @request = Request.find(params[:request_id])
    @favorite = current_user.favorites.find_by(request_id: @request.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
 end
end
