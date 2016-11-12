class AddImageToBrands < ActiveRecord::Migration
  def self.up
    add_attachment :brands, :brand_image
  end

  def self.down
    remove_attachment :brands, :brand_image
  end
end
