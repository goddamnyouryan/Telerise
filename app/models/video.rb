class Video < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes
  
  def vote_up(user)
    @vote = Vote.create(:vote => "up", :user_id => user.id, :video_id => self.id)
    self.votes_up = self.votes_up + 1
    self.save!
  end
  
  def vote_down(user)
    @vote = Vote.create(:vote => "down", :user_id => user.id, :video_id => self.id)
    self.votes_down = self.votes_down + 1
    self.save!
  end
  
  def remove_vote_up(user)
    @vote = Vote.find_by_user_id_and_video_id(user.id, self.id)
    @vote.destroy
    self.votes_up = self.votes_up - 1
    self.save!
  end
  
  def remove_vote_down(user)
    @vote = Vote.find_by_user_id_and_video_id(user.id, self.id)
    @vote.destroy
    self.votes_down = self.votes_down - 1
    self.save!
  end
  
  def reverse_vote_up(user)
    @vote = Vote.find_by_user_id_and_video_id(user.id, self.id)
    @vote.destroy
    self.votes_up = self.votes_up - 1
    @vote = Vote.create(:vote => "down", :user_id => user.id, :video_id => self.id)
    self.votes_down = self.votes_down + 1
    self.save!
  end
  
  def reverse_vote_down(user)
    @vote = Vote.find_by_user_id_and_video_id(user.id, self.id)
    @vote.destroy
    self.votes_down = self.votes_down - 1
    @vote = Vote.create(:vote => "up", :user_id => user.id, :video_id => self.id)
    self.votes_up = self.votes_up + 1
    self.save!
  end

  
end
