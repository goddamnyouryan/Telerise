class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  attr_accessible :message, :video_id, :user_id
end
