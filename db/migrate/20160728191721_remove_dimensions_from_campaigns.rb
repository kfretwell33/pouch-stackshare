class RemoveDimensionsFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :dimensions, :string
  end
end
