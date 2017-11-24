class Message < ApplicationRecord
  belongs_to :run
  belongs_to :user

  validates :content, presence: true

  # scope :between, -> (sender_id,recipient_id) do
  #  where(“(message.user_id = ? AND message.run.user_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)”, sender_id,recipient_id, recipient_id, sender_id)
  #  end
end
