class AddActiveToUserTours < ActiveRecord::Migration[5.0]
  def change
    add_column :tours_users, :active_subscription, :boolean, default: true
    add_index :tours_users, :active_subscription
  end
end
