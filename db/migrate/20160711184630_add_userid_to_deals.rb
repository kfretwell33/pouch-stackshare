class AddUseridToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :user_id, :integer
    add_index :deals, :user_id
  end
end
