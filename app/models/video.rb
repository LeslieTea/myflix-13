class Video < ActiveRecord::Base
  belongs_to :category
  
  def title_only?
    description.blank?
  end
  
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_term)
    where("title LIKE ?", "%#{search_term}%").order("created_at ASC")
  end
end

#we call Video.search_by_title("Family")
#return: empty array, if no videos are found
#return array if one or more videos are found
#write tests for no videos and multiples and one found
#when doing a search in active record, we need keyword LIKE