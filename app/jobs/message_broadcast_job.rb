class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, to)
    ActionCable.server.broadcast "chat_rooms_#{message.chat_room.id}_channel",
                                 message: render_message(message)

    ActionCable.server.broadcast "user_#{to}_channel",
                                 message: render_message_notification(message)


  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end

   def render_message_notification(message)
    MessagesController.render partial: 'messages/message_notification', locals: {message: message}
   end


end