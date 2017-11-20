class Run < ApplicationRecord
  belongs_to :user
  validates :location, :date, :description, :distance, :capacity, presence: true

  # Enables photo uploads
  mount_uploader :photo, PhotoUploader

  # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
