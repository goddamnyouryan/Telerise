class AddVotesToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :votes_up, :integer, { :null => false, :default => 0 }
    add_column :comments, :votes_down, :integer, { :null => false, :default => 0 }
  end

  def self.down
    remove_column :comments, :votes_down
    remove_column :comments, :votes_up
  end
end
