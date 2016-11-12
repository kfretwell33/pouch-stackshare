class RemoveBrandFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :brand, :string
  end
end
