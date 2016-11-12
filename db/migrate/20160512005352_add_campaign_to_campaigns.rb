class AddCampaignToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :campaign_name, :string
  end
end
