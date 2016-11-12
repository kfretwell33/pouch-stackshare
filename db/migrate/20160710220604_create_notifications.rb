class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.datetime :send_date
      t.boolean :scheduled

      t.timestamps null: false
    end
  end
end
