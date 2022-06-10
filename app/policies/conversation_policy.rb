class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    record.users.exists?(user.id)
  end

  def create?
    true
  end
end
