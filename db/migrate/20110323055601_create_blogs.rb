class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.boolean :is_public
      t.string  :image_file_name
      t.string  :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.datetime :public_datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
