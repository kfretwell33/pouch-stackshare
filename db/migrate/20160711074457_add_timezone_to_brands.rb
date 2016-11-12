class AddTimezoneToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :time_zone, :string
  end
end
