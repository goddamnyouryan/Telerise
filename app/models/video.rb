class Video < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, :as => :votable
  
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
