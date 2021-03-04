class Proposal < ApplicationRecord
    belongs_to :request
    belongs_to :user
    has_one :room
    
    has_many :notifications, dependent: :destroy
    enum status: [:proposing, :confirm, :confirm_request, :complete]
end
