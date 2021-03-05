class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  enum display_type: [:normal, :confirm_request, :complete_request]
end
