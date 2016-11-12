class AddDescriptionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :description, :string
    add_column :campaigns, :fb_description, :string
  end
end
