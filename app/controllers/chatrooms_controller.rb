class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
    messages = @chatroom.messages
    new_messages = messages.where.not(user_id: current_user[:id]).where(read: nil)
    unless new_messages.empty?
      new_messages.each do |message|
        message.update_attribute(:read, DateTime.now)
      end
    end
  end
end
