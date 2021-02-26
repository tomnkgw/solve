class Room < ApplicationRecord
  belongs_to :request
  belongs_to :proposal
  has_many :messages
  
end
