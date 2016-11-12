class AddDetailsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :expiration_date, :timestamptz
    add_column :deals, :brand, :string
    add_column :deals, :brand_id, :integer
  end
end
