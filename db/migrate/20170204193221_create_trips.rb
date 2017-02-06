class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.text :description
      t.string :language
      t.string :start

      t.timestamps
    end
  end
end
