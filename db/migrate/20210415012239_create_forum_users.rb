class CreateForumUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_users do |t|
      t.integer :forum_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
