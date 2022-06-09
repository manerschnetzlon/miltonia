class Conversation < ApplicationRecord
  has_many :participations
  has_many :users, through: :participations
  has_many :milts

  attr_accessor :other_user
end
