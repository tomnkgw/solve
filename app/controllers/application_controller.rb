class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notification_badge
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  
  def set_notification_badge
    @unread_notification_count = if current_user.present?
      current_user.passive_notifications.where(checked: false).count
    else
      0
    end
  end
end
