class Search < ApplicationRecord
   belongs_to :user
   # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
