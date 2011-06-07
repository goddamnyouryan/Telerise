class Video < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, :as => :votable
  
  def to_param
    "#{id}-#{title.slice(0..40).gsub(/\W/, '-').downcase.gsub(/-{2,}/,'-')}"
  end
  
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
  
  def controversial
    return (self.votes_up + self.votes_down).to_f / [(self.votes_up - self.votes_down).abs, 1].max
  end
  
  def best
    return self.votes_up - self.votes_down
  end
  
  def random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
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
