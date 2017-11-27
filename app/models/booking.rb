class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :run

  validates :run_id, :uniqueness => {:scope=>:user_id}
end
