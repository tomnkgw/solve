class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :requests, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #active_notifications: 自分からの通知
  #passive_notification:　相手からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
   
  def already_favorited?(request)
    self.favorites.exists?(request_id: request.id)
  end
end
