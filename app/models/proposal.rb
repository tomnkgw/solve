class Proposal < ApplicationRecord
    belongs_to :request
    belongs_to :user
    
    enum status: [:proposing, :confirm, :sorry]
end
