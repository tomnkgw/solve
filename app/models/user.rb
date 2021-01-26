class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :requests, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
   
   def already_favorited?(request)
     self.favorites.exists?(request_id: request.id)
   end
end
