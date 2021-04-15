class CreateForumPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_posts do |t|
      t.integer :forum_id, null: false
      t.integer :user_id, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
