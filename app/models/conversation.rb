class Conversation < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many :milts, dependent: :destroy

  attr_accessor :other_user

  def self.ordered_by_time
    joins(:milts).reorder('milts.created_at DESC').uniq
  end

  def correspondant(user)
    users.where.not(id: user.id).first
  end

  # def conversations_of_correspondant(user)
  #   correspondant(user).conversations
  #   .correspondants.map(&:correspondants).flatten
  # end

  # def self.correspondants(user)
  #   user.conversations.map { |conversation| conversation.correspondant(user) }
  # end

  # def self.correspondants_of_correspondant(user)
  #   correspondant = correspondant(user)
  #   correspondant.conversations.each { |conversation| conversation.correspondant(user) }
  # end
end
