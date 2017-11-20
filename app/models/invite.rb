class Invite < ApplicationRecord
  belongs_to :run
  belongs_to :user

  validates :status, presence: true
end
