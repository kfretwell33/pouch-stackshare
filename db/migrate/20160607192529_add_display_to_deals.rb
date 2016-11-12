class AddDisplayToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :display, :boolean
  end
end
