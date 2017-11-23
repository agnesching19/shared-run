class Event < ApplicationRecord
  validates :date, :time, :location, :distance, presence: true
  belongs_to :user

  # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
