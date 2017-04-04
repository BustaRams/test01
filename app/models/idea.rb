class Idea < ApplicationRecord
  belongs_to :tour
  validates_presence_of :text
end
