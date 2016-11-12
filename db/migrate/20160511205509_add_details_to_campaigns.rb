class AddDetailsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :expiration_date, :timestamptz
    add_column :campaigns, :brand_id, :integer
  end
end
