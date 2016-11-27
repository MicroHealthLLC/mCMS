class AddReceiverIdToChatRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :receiver_id, :integer
  end
end
