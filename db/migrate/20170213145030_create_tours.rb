class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :description
      t.integer :owner_id
      t.datetime :start_time
      t.integer :category_id

      t.timestamps
    end
  end
end
