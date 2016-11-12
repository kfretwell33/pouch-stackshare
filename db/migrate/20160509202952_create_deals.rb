class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :uid
      t.string :user
      t.string :campaign
      t.string :campaign_id
      t.string :campaign_url

      t.timestamps null: false
    end
  end
end
