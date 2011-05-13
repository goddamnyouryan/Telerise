class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.text :description
      t.string :provider
      t.integer :height
      t.integer :width
      t.text :embed
      t.string :thumb
      t.integer :thumb_height
      t.integer :thumb_width

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
