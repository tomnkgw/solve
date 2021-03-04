class Notification < ApplicationRecord
  #新しい通知からデータを取得する
  default_scope -> { order(created_at: :desc) }
  belongs_to :request, optional: true
  belongs_to :proposal, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
