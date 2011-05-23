class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  has_many :votes, :as => :votable
  attr_accessible :message, :video_id, :user_id
  
  def total_votes
    self.votes_up + self.votes_down
  end
  
  require 'statistics2'
  def ranking
      n = self.votes_up + self.votes_down
      if n == 0
        return 0
      end
      z = 1.281551565545 # 80% confidence
      p = self.votes_up.to_f / n
      left = p + 1/(2*n)*z*z
      right = z * Math.sqrt(p*(1-p)/n + z*z/(4*n*n))
      under = 1+1/n*z*z
      return (left - right) / under
  end
  
  def vote_up(user)
    @vote = Vote.create(:vote => "up", :user_id => user.id, :votable_id => self.id, :votable_type => "Comment")
    self.votes_up = self.votes_up + 1
    self.save!
    self.user.comment_karma = self.user.comment_karma + 1
    self.user.save!
  end
  
  def vote_down(user)
    @vote = Vote.create(:vote => "down", :user_id => user.id, :votable_id => self.id, :votable_type => "Comment")
    self.votes_down = self.votes_down + 1
    self.save!
    self.user.comment_karma = self.user.comment_karma - 1
    self.user.save!
  end
  
  def remove_vote_up(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Comment"]
    @vote.destroy
    self.votes_up = self.votes_up - 1
    self.save!
    self.user.comment_karma = self.user.comment_karma - 1
    self.user.save!
  end
  
  def remove_vote_down(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Comment"]
    @vote.destroy
    self.votes_down = self.votes_down - 1
    self.save!
    self.user.comment_karma = self.user.comment_karma + 1
    self.user.save!
  end
  
  def reverse_vote_up(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Comment"]
    @vote.destroy
    self.votes_up = self.votes_up - 1
    @vote = Vote.create(:vote => "down", :user_id => user.id, :votable_id => self.id, :votable_type => "Comment")
    self.votes_down = self.votes_down + 1
    self.save!
    self.user.comment_karma = self.user.comment_karma - 2
    self.user.save!
  end
  
  def reverse_vote_down(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Comment"]
    @vote.destroy
    self.votes_down = self.votes_down - 1
    @vote = Vote.create(:vote => "up", :user_id => user.id, :votable_id => self.id, :votable_type => "Comment")
    self.votes_up = self.votes_up + 1
    self.save!
    self.user.comment_karma = self.user.comment_karma + 2
    self.user.save!
  end
end
