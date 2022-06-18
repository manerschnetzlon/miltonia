class Conversation < ApplicationRecord
  has_many :participations
  has_many :users, through: :participations
  has_many :milts

  attr_accessor :other_user

  def self.ordered_by_time
    joins(:milts).reorder('milts.created_at DESC').uniq
  end
end
