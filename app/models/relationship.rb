class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :leader, class_name: "User"
  
  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end
end