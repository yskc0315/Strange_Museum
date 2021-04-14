class AddStatusToMuseums < ActiveRecord::Migration[5.2]
  def change
    add_column :museums, :status, :integer
  end
end
