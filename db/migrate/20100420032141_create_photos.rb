class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.text		:tags
      t.string		:caption,	:null => false
      t.string		:scope,		:default => "private"
      t.string		:photo_path,	:null => false
      t.integer		:album_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
