class ChatRoom < ApplicationRecord
  has_secure_token

  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  has_many :messages, dependent: :destroy

  def group
    [user_id, receiver_id]
  end
end
