class Trip < ApplicationRecord
	belongs_to :user
	belongs_to :category

	has_attached_file :trip_img, styles: { mini_img: "350x250>", grande_img: "475x325>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :trip_img, content_type: /\Aimage\/.*\z/
end
