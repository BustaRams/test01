class RemoveForeigneeysFromMessages < ActiveRecord::Migration[5.0]
  def up
    drop_table :messages

    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :tour_id

      t.timestamps
    end

    add_index :messages, [:tour_id, :user_id]
  end

  def down
    puts 'Nope'
  end
end
