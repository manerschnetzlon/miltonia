class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    # @conversation ||= Conversation.find(params[:conversation_id])
    authorize @conversation
    @conversation.milts.where(seen?: false).each { |milt| milt.update(seen?: true) }
  end
end
