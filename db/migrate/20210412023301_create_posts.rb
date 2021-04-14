class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :museum_id, null: false
      t.string :title
      t.text :body
      t.integer :how_to_visit
      t.integer :companion

      t.timestamps
    end
  end
end
