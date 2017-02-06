class AddCategoryIdToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :category_id, :integer
  end
end
