class Video < ActiveRecord::Base
  belongs_to :category
  
  def title_only?
    description.blank?
  end
  
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_term)
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end

