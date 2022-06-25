class MiltsController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])

    milt = Milt.new(milt_params)
    milt.conversation = conversation
    milt.sender = current_user
    authorize milt

    correspondant = current_user.correspondant(conversation)

    respond_to do |format|
      if milt.save
        current_user.update(milts_sent_count: current_user.milts_sent_count + 1)
        correspondant.update(milts_received_count: correspondant.milts_received_count + 1)
        MiltsUnseen.conversations(conversation, current_user).destroy_all
        MiltsUnseen.create(user: correspondant, milt: milt)
        format.html do
          current_user.milts_count -= 1
          render "conversations/show", status: :unprocessable_entity unless current_user.save
          partial_receiver_conversations = render_to_string(partial: "conversations", locals: { conversations: correspondant.conversations.ordered_by_time, current_user: correspondant, user: current_user })
          partial_milt = render_to_string(partial: "milt", locals: { milt: milt })
          partial_milts_count = render_to_string(partial: "counter_milts", locals: { current_user: current_user })
          partial_footer = render_to_string(partial: "footer_show", locals: { current_user: current_user, conversation: conversation, milt: milt })
          partial_exchange_milts = render_to_string(partial: "exchange_milts", locals: { current_user: correspondant })
          ConversationChannel.broadcast_to(
            conversation, {
              milt: partial_milt,
              milts_count: partial_milts_count,
              # sender_conversations: sender_conversations,
              receiver_conversations: partial_receiver_conversations,
              footer: partial_footer,
              exchange_milts: partial_exchange_milts,
              correspondant_id: correspondant.id,
              user_id: current_user.id,
              conversation_id: conversation.id
            }
          )
        end
        format.json
      else
        format.html { render "conversations/show", status: :unprocessable_entity, locals: { current_user: current_user, conversation: Conversation.find(params[:conversation_id]), milt: Milt.new } }
        format.json
      end
    end
  end

  def add_received_milts
    savings = current_user.savings_count + current_user.milts_received_count
    new_counts = { milts_received_count: 0, savings_count: savings }
    # raise unless current_user.milts_received_count.nil?
    respond_to do |format|
      if current_user.update(new_counts) && current_user.milts_received_count.zero?
        format.html { redirect_to insight_path }
        format.json
      else
        format.html { render "pages/insight", status: :unprocessable_entity, locals: { current_user: current_user } }
        format.json
      end
    end
  end

  def add_sent_milts
    savings = current_user.savings_count + current_user.milts_sent_count
    new_counts = { milts_sent_count: 0, savings_count: savings }
    # raise unless current_user.milts_sent_count.nil?
    respond_to do |format|
      if current_user.update(new_counts) && current_user.milts_sent_count.zero?
        format.html { redirect_to insight_path }
        format.json
      else
        format.html { render "pages/insight", status: :unprocessable_entity, locals: { current_user: current_user } }
        format.json
      end
    end
  end

  private

  def milt_params
    params.require(:milt).permit(:receiver_id)
  end
end
