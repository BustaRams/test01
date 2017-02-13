class AddIndexToToursUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :tours_users, :id, :primary_key
  end
end
