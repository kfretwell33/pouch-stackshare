class AddNotificationsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :alert_one, :string
    add_column :campaigns, :alert_two, :string
    add_column :campaigns, :send_date_one, :timestamptz
    add_column :campaigns, :send_date_two, :timestamptz
  end
end
