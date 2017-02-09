class AddAttachmentTripImgToTrips < ActiveRecord::Migration
  def self.up
    change_table :trips do |t|
      t.attachment :trip_img
    end
  end

  def self.down
    remove_attachment :trips, :trip_img
  end
end
