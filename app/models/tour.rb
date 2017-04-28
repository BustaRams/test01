class Tour < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :tours_users
  has_many :users, through: :tours_users
  has_many :ideas, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :languages, through: :users
  belongs_to :main_language, class_name: 'Language', foreign_key: 'language_id'
  has_many :tour_languages, dependent: :destroy

  accepts_nested_attributes_for :tour_languages

  validates_presence_of :name, :description, :owner_id, :start_time, :from_point, :to_point

  has_attached_file :tour_img, styles: {
      thumb: '100x100>',
      mini_img: '350x250>',
      grande_img: '475x325>'
  }, default_url: "/images/missing.jpg"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :tour_img, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :tour_img

  def collected_languages
    result = self.users.includes(:language).map do |user|
      user.language.name
    end
    result << self.owner.language.name
    result.compact.uniq
  end
end
