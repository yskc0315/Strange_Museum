class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body
      t.string :where
      t.string :when
      t.boolean :lock, default: false, null: false

      t.timestamps
    end
  end
end
