class Proposal < ApplicationRecord
    belongs_to :request
    belongs_to :user
    has_one :room
    
    enum status: [:proposing, :confirm, :sorry, :confirm_request]
end
