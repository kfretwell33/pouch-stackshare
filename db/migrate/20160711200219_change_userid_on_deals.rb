class ChangeUseridOnDeals < ActiveRecord::Migration
  def change
  	change_column :deals, :user_id, :string
  end
end
