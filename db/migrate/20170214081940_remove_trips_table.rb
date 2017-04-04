class RemoveTripsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :trips
  end

  def down
    puts 'Nope.'
  end
end
