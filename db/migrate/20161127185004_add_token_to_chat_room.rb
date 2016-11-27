class AddTokenToChatRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :token, :string
  end
end
