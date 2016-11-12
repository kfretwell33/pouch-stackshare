class AddFbHeightToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :fb_image_height, :integer
  end
end
