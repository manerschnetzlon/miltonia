class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome

  def welcome
  end

  def home
    @conversations = current_user.conversations.ordered_by_time
    @participation = Participation.new
  end

  def settings
  end
end
