class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    # @conversation ||= Conversation.find(params[:conversation_id])
    authorize @conversation
    @milts_load = params[:load_more] ? params[:load_more].to_i : 1

    @milts = @conversation.milts.last(50 * @milts_load)
    @load_more = @conversation.milts.count != @milts.count
    MiltsUnseen.conversations(@conversation, current_user).destroy_all
    # raise if params[:load_more]

    # respond_to do |format|
    #   format.html { redirect_to conversation_path(@conversation) }
    #   format.json
    # end
  end
end
