class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string 		:album_name,		:null => false
      t.boolean		:public_private,	:null => false
      t.user_id		:integer,		:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
