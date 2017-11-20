class Message < ApplicationRecord
  belongs_to :run
  belongs_to :user

  validates :content, presence: true
end
