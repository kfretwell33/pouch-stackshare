class RemoveDetailsFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :campaign_id, :string
  end
end
