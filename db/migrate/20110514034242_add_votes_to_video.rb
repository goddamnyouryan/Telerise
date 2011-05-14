class AddVotesToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :votes, :integer, { :null => false, :default => 0 }
  end

  def self.down
    remove_column :videos, :votes
  end
end
