class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.integer :post_id
      t.string :picture_id

      t.timestamps
    end
  end
end
