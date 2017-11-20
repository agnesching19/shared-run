class Preference < ApplicationRecord
  belongs_to :user
  validates :time, :date, :location, :sociability, presence: true
end
