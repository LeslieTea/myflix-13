class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :small_cover_url
    	t.string :large_cover_url
    	t.string :title
    	t.string :description
    	t.integer :category_id
    	t.timestamps
    end
  end
end
