class Tour < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_and_belongs_to_many  :users

  validates_presence_of :name, :description, :owner_id, :start_time

  #has_attached_file :trip_img, styles: { mini_img: "350x250>", grande_img: "475x325>" }, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :trip_img, content_type: /\Aimage\/.*\z/
end
