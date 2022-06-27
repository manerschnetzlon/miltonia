class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars do |t|
      t.string :emoji
      t.integer :price, default: 0
      t.timestamps
    end
  end
end
