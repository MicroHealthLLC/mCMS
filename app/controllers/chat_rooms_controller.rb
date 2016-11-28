class ChatRoomsController < ApplicationController
  before_action  :authenticate_user!
  before_action  :set_chat_room, only: [:show]
  before_action :authorize, only: [:show]
  def create_or_find
    receiver = User.find params[:user_id]
    @chat_room = ChatRoom.where(user_id: current_user.id).where(receiver_id: receiver.id).or(ChatRoom.where(user_id: receiver.id).where(receiver_id: current_user.id)).first

    @chat_room = ChatRoom.where(user_id: current_user.id).where(receiver_id: receiver.id).first_or_create if @chat_room.nil?
    redirect_to chat_room_path(token: @chat_room.token)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def show
     @message = Message.new
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.includes(:messages).find_by(token: params[:token])
    render_404 if @chat_room.nil?
  end

  def authorize
    unless current_user.id.in?([@chat_room.user.id, @chat_room.receiver.id])
      render_403
    end
  end

end