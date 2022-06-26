class MiltsRequestsController < ApplicationController
  def create
    if current_user.milts_requests.exists? && current_user.milts_requests.last.finished_date.past?
      current_user.update(milts_count: current_user.milts_count + 8)
      current_user.milts_requests.last.destroy
    end
    return if current_user.milts_requests.exists? && current_user.milts_requests.last.finished_date.future?

    @milts_request = MiltsRequest.new
    @milts_request.user = current_user
    @milts_request.finished_date = DateTime.now + 4.hours
    if @milts_request.save
      redirect_to insight_path
      # respond_to do |format|
      #   format.html { redirect_to insight_path }
      #   format.json
      # end
    else
      render "pages/insight", status: :unprocessable_entity
    end
  end

  def counting_up_to_new_milts
    respond_to do |format|
      format.html { redirect_to insight_path }
      format.json
    end
  end
end
