class User < ApplicationRecord
  has_many :tours_users
  has_many :tours, through: :tours_users
  has_many :messages, through: :tours
  belongs_to :language
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :First_name, :Last_name, :language_id, :birthday
end
