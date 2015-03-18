class QueueItem < ActiveRecord::Base
  
  validates_numericality_of :position, {only_integer: true}
  belongs_to :user
  belongs_to :video
  
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  
 
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end
  
   def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end
  end
  
  def category_name
    category.name
  end
  
  def self.append_video_to_user(user, video)
    queue_item = QueueItem.new(user: user, video: video)
    queue_item.position = user.queue_items.count + 1
    queue_item.save
  end
  
private
  
  def review
    @review ||= Review.where(user_id: user.id, video_id: video_id).take
  end

end