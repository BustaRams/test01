class TAndCForUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :terms_conditions, :boolean, default: false
  end
end
