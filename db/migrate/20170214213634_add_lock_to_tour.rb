class AddLockToTour < ActiveRecord::Migration[5.0]
  def change
    add_column :tours, :locked, :boolean, default: false
  end
end
