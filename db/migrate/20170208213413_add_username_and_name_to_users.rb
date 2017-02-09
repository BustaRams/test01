class AddUsernameAndNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :First_name, :string
    add_column :users, :Last_name, :string
  end
end
