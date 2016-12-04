class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create_commit { MessageBroadcastJob.perform_later(self, self.to.first ) }

  def to
   chat_room.group  - [user_id]
  end

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
