class AddDimensionsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :dimensions, :string
  end
end
