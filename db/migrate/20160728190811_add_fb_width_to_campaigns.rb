class AddFbWidthToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :fb_image_width, :integer
  end
end
