class CreateMiltsRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :milts_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :finished_date
      t.timestamps
    end
  end
end
