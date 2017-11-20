class Event < ApplicationRecord
  validates :date, :time, :location, :distance, presence: true
end
