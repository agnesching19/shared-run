class Event < ApplicationRecord
  validates :date, :time, :location, :distance, presence: true
  belongs_to :user
end
