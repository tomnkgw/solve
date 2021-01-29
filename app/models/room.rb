class Room < ApplicationRecord
  belongs_to :request
  belongs_to :proposal
end
