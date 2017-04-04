class AddImgToTour < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :tours, :tour_img
  end

  def self.down
    remove_attachment :tours, :tour_img
  end
end
