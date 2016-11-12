class AddColumnsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :user_name, :string
    add_column :deals, :campaign_name, :string
    add_column :deals, :brand_name, :string
  end
end
