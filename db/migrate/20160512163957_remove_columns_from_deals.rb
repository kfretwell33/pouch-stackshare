class RemoveColumnsFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :user, :string
    remove_column :deals, :campaign, :string
    remove_column :deals, :brand, :string
  end
end
