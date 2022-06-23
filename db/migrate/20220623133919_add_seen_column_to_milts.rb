class AddSeenColumnToMilts < ActiveRecord::Migration[6.1]
  def change
    add_column :milts, :seen?, :boolean, default: false
  end
end
