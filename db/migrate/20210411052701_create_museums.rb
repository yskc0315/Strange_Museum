class CreateMuseums < ActiveRecord::Migration[5.2]
  def change
    create_table :museums do |t|
      t.string :name, null: false
      t.integer :genre_id
      t.string :appearance_image_id
      t.string :opening_time, null: false
      t.string :closing_time, null: false
      t.string :regular_holiday, null: false
      t.integer :prefecture, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.integer :entrance_fee
      t.boolean :shop
      t.text :url

      t.timestamps
    end
  end
end
