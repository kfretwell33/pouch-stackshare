class RemoveTimezoneFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :time_zone, :string
  end
end
