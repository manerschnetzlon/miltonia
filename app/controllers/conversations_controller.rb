class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    @conversation ||= Conversation.find(params[:conversation_id])
    @milt = Milt.new
    authorize @conversation
  end
end
