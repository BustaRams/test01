class PointToTours < ActiveRecord::Migration[5.0]
  def change
    add_column :tours, :from_point, :string
    add_column :tours, :to_point, :string
  end
end
