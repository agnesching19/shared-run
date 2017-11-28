class Run < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :invites
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  validates :location, :date, :title, :description, :run_distance, :capacity, presence: true

  # Enables photo uploads
  mount_uploader :photo, PhotoUploader

  # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  # Enables pgsearch
  include PgSearch
  pg_search_scope :global_search,
    against: [:location]
    # ,
    # associated_against: {
    #   runs: [:run_date]
    # }
end
