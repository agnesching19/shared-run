class Review < ApplicationRecord
  belongs_to :user
  belongs_to :run
  # belongs_to :reviewer, class_name: "User"
  validates :punctuality, presence: true
  # validates :user_id, :run_id, :reviewer_id

  validates :run_id, :uniqueness => {:scope=>:user_id}
end
