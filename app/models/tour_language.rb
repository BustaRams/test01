class TourLanguage < ApplicationRecord
  belongs_to :tour
  belongs_to :language
end
