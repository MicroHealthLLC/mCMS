# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{params['chat_user_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
