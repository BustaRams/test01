class AddTimestampsToTourUsers < ActiveRecord::Migration[5.0]
  def change
    add_column(:tours_users, :created_at, :datetime)
    add_column(:tours_users, :updated_at, :datetime)
  end
end
