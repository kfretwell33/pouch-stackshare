class FixIdTypesOnDeals < ActiveRecord::Migration
  def change
  	change_column :deals, :campaign_id, 'integer USING CAST(campaign_id AS integer)'
  end
end
