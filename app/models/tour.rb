class Tour < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :tours_users
  has_many :users, through: :tours_users
  has_many :ideas
  has_many :messages
  has_many :languages, through: :users

  validates_presence_of :name, :description, :owner_id, :start_time

  has_attached_file :tour_img, styles: {
      thumb: '100x100>',
      mini_img: '350x250>',
      grande_img: '475x325>'
  }, default_url: "/images/missing.jpg"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :tour_img, :content_type => /\Aimage\/.*\Z/

  def collected_languages
    result = self.users.includes(:language).map do |user|
      user.language.name
    end
    result.compact.uniq
  end
end
