class AddAvatarReferenceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :avatar, foreign_key: true, optional: true
  end
end
