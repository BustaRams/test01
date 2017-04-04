class CreateTourLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :tour_languages do |t|
      t.references :tour, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
