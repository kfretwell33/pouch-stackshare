class AddBrandNameToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :brand_name, :string
  end
end
