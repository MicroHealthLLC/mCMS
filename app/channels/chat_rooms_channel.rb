# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
    ChatRoom.where(id: data['chat_room_id']).first.update(message_seen: false)
  end

  def update_message(data)
    chat_room = ChatRoom.where(id: data['chat_room_id']).first
    chat_room.update(message_seen: true)
  end
end
