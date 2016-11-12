class AddExpirationsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :stop_scheduling, :boolean
  end
end
