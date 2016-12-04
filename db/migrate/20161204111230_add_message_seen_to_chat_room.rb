class AddMessageSeenToChatRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :message_seen, :boolean, default: true
  end
end
