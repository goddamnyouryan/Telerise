class AddDownVotesToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :votes_down, :integer, { :null => false, :default => 0 }
    rename_column :videos, :votes, :votes_up
  end

  def self.down
    remove_column :videos, :votes_down
  end
end
