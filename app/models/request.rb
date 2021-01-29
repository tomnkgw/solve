class Request < ApplicationRecord
    belongs_to :user
    has_many :proposals
    has_many :favorites, dependent: :destroy
    has_many :rooms, dependent: :destroy
end
