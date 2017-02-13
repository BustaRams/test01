class ToursUser < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  scope :acive, -> {where(active_subscription: true)}
end