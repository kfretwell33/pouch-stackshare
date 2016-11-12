class AddNameToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :brand_name, :string
  end
end
