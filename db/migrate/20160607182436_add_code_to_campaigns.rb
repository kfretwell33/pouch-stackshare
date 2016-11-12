class AddCodeToCampaigns < ActiveRecord::Migration
  def change
  	add_column :campaigns, :promo_code, :string
  end
end
