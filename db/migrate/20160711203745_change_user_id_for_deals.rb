class ChangeUserIdForDeals < ActiveRecord::Migration
  def change
  	change_column :deals, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
