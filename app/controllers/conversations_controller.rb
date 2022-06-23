class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    # @conversation ||= Conversation.find(params[:conversation_id])
    authorize @conversation
    MiltsUnseen.conversations(@conversation, current_user).destroy_all
  end
end
