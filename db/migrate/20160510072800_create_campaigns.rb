class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :brand
      t.string :campaign
      t.string :campaign_id
      t.string :campaign_url

      t.timestamps null: false
    end
  end
end
