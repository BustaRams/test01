class ToursUser < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  scope :active, -> {where(active_subscription: true)}
end