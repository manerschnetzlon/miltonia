class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    @milt = Milt.new
  end
end
