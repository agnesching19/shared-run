class Event < ApplicationRecord
  validates :date, :time, :location, :run_distance, presence: true
  belongs_to :user
  has_many :reservations

  # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
