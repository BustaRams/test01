class AddLanguageToTour < ActiveRecord::Migration[5.0]
  def change
    add_column :tours, :language_id, :integer
  end
end
