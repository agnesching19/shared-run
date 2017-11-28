class Review < ApplicationRecord
  belongs_to :run
  belongs_to :user
  belongs_to :reviewer, class_name: "User"
  validates :punctuality, presence: true
  # validates :user_id, :run_id, :reviewer_id
end
