class User < ActiveRecord::Base
  has_many :videos, :dependent => :destroy 
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
  
  def voted_for?(voteable)
    0 < Vote.count(:all, :conditions => 
                        ["user_id = ? AND vote = ? AND votable_id = ? AND votable_type = ?",
                        self.id, "up", voteable.id, voteable.class.name ]
                  )
  end
  
  def voted_against?(voteable)
    0 < Vote.count(:all, :conditions => 
                        ["user_id = ? AND vote = ? AND votable_id = ? AND votable_type = ?",
                        self.id, "down", voteable.id, voteable.class.name ]
                  )
  end
  
  
end
