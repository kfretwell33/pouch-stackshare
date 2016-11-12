class RemoveCampaignFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :campaign, :string
  end
end
