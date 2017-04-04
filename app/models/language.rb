class Language < ApplicationRecord
 has_many :users
 has_many :tour_languages
end
