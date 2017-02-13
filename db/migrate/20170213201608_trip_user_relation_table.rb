class TripUserRelationTable < ActiveRecord::Migration[5.0]
  def change
    def change
      create_table :users_trips, id: false do |t|
        t.belongs_to :user, index: true
        t.belongs_to :tour, index: true
        t.boolean :kicked, default: false
      end
    end
  end
end
