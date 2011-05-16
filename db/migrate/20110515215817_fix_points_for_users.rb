class FixPointsForUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :points
    add_column :users, :video_karma, :integer, { :null => false, :default => 0 }
    add_column :users, :comment_karma, :integer, { :null => false, :default => 0 }
  end

  def self.down
  end
end
