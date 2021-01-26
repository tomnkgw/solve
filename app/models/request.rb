class Request < ApplicationRecord
    belongs_to :user
    has_many :proposals
    has_many :favorites, dependent: :destroy
end
