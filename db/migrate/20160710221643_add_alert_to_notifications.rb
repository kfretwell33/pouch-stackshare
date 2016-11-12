class AddAlertToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :alert, :string
  end
end
