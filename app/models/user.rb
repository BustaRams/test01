class User < ApplicationRecord
  has_many :tours_users
  has_many :tours, through: :tours_users
  has_many :messages, through: :tours
  belongs_to :language
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :First_name, :Last_name, :language_id, :birthday
  validate do |user|
    user.must_accept_terms
  end

  def must_accept_terms
    errors.add(:base, 'You must accept terms and conditions of this service.') unless terms_conditions == true
  end
end
