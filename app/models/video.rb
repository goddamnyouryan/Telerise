class Video < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, :as => :votable
  
  def total_votes
    self.votes_up + self.votes_down
  end
  
  def epoch(date)
    date.to_i
  end
  
  def hot
    s = self.votes_up - self.votes_down
    order = Math.log10(([s.abs, 1].max))
    if s > 0 
      sign = 1
    elsif s < 0
      sign = -1
    else
      sign = 0
    end
    seconds = epoch(self.created_at) - 1134028003
    return (((order + sign) * seconds) /45000).round
  end
  
  require 'statistics2'
  def ranking(pos, n, power)
      if n == 0
          return 0
      end
      z = Statistics2.pnormaldist(1-power/2)
      phat = 1.0*pos/n
      (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end
  
  def vote_up(user)
    @vote = Vote.create(:vote => "up", :user_id => user.id, :votable_id => self.id, :votable_type => "Video")
    self.votes_up = self.votes_up + 1
    self.save!
    self.user.video_karma = self.user.video_karma + 1
    self.user.save!
  end
  
  def vote_down(user)
    @vote = Vote.create(:vote => "down", :user_id => user.id, :votable_id => self.id, :votable_type => "Video")
    self.votes_down = self.votes_down + 1
    self.save!
    self.user.video_karma = self.user.video_karma - 1
    self.user.save!
  end
  
  def remove_vote_up(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Video"]
    @vote.destroy
    self.votes_up = self.votes_up - 1
    self.save!
    self.user.video_karma = self.user.video_karma - 1
    self.user.save!
  end
  
  def remove_vote_down(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Video"]
    @vote.destroy
    self.votes_down = self.votes_down - 1
    self.save!
    self.user.video_karma = self.user.video_karma + 1
    self.user.save!
  end
  
  def reverse_vote_up(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Video"]
    @vote.destroy
    self.votes_up = self.votes_up - 1
    @vote = Vote.create(:vote => "down", :user_id => user.id, :votable_id => self.id, :votable_type => "Video")
    self.votes_down = self.votes_down + 1
    self.save!
    self.user.video_karma = self.user.video_karma - 2
    self.user.save!
  end
  
  def reverse_vote_down(user)
    @vote = Vote.first :conditions => [ "user_id = ? AND votable_id = ? AND votable_type = ?", user.id, self.id, "Video"]
    @vote.destroy
    self.votes_down = self.votes_down - 1
    @vote = Vote.create(:vote => "up", :user_id => user.id, :votable_id => self.id, :votable_type => "Video")
    self.votes_up = self.votes_up + 1
    self.save!
    self.user.video_karma = self.user.video_karma + 2
    self.user.save!
  end

  
end
