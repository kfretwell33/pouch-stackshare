class AddIndexToCampaigns < ActiveRecord::Migration
  def change
  	add_index :campaigns, :brand_id
  	add_index :deals, :campaign_id
  end
end
