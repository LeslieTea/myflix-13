class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false
  
  has_many :queue_items, -> { order(position: :asc, updated_at: :desc) }
  has_many :reviews, -> { order("created_at DESC") }
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id 
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
  
  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end
end