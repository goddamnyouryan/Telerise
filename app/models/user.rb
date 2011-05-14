class User < ActiveRecord::Base
  has_many :videos
  has_many :comments
  has_many :votes
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
  
  def voted_for?(voteable)
    0 < Vote.count(:all, :conditions => 
                        ["user_id = ? AND vote = ? AND video_id = ?",
                        self.id, "up", voteable.id ]
                  )
  end
  
  def voted_against?(voteable)
    0 < Vote.count(:all, :conditions => 
                        ["user_id = ? AND vote = ? AND video_id = ?",
                        self.id, "down", voteable.id ]
                  )
  end
  
  
end
