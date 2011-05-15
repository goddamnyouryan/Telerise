class MakeVotesPolymorphic < ActiveRecord::Migration
  def self.up
    rename_column :votes, :video_id, :votable_id
    add_column :votes, :votable_type, :string
  end

  def self.down
  end
end
