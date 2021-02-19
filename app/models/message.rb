class Message < ApplicationRecord
  belongs_to :user
  enum display_type: [:normal, :confirm_request]
end
