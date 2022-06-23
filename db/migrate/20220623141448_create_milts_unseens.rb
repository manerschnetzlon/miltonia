class CreateMiltsUnseens < ActiveRecord::Migration[6.1]
  def change
    create_table :milts_unseens do |t|
      t.references :user, null: false, foreign_key: true
      t.references :milt, null: false, foreign_key: true
      t.timestamps
    end
  end
end
