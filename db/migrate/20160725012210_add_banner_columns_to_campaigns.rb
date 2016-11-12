class AddBannerColumnsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :banner_hex_code, :string
    add_column :campaigns, :banner_text, :string
  end
end
