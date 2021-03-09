class Request < ApplicationRecord
    belongs_to :user
    has_many :proposals
    has_many :favorites, dependent: :destroy
    has_many :rooms, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
    enum status: [:requesting, :confirm, :confirm_request]
    
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and request_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        request_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_proposal!(current_user, proposal_id)
    # すでに「提案」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and request_id = ? and action = ? ", current_user.id, user_id, id, 'proposal'])
    # 提案されていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        request_id: id,
        visited_id: user_id,
        action: 'proposal'
      )
      notification.save if notification.valid?
    end
  end
  
  def create_notification_confirm_request!(current_user, proposal_user_id)

    notification = current_user.active_notifications.new(
      request_id: id,
      visited_id: proposal_user_id,
      action: 'confirm_request'      
    )
    notification.save if notification.valid?
  end
  
  def create_notification_complete_request!(current_user)

    notification = current_user.active_notifications.new(
      request_id: id,
      visited_id: user_id,
      action: 'complete_request'      
    )
    notification.save if notification.valid?
  end
  
  def create_notification_complete!(current_user, proposal_user_id)

    notification = current_user.active_notifications.new(
      request_id: id,
      visited_id: proposal_user_id,
      action: 'complete'      
    )
    notification.save if notification.valid?
  end
  
  def create_notification_reject!(current_user)

    notification = current_user.active_notifications.new(
      request_id: id,
      visited_id: user_id,
      action: 'reject'      
    )
    notification.save if notification.valid?
  end
  
  def create_notification_confirm!(current_user)

    notification = current_user.active_notifications.new(
      request_id: id,
      visited_id: user_id,
      action: 'confirm'      
    )
    notification.save if notification.valid?
  end
end