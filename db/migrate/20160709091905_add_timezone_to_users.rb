class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_timezone, :float
  end
end
