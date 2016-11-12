class AddIndexToNotification < ActiveRecord::Migration
  def change
  	add_index :notifications, :campaign_id
  	add_index :notifications, :user_id
  	change_column :notifications, :send_date, :timestamptz
  end
end
