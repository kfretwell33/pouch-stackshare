class AddAppDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_token, :string
    add_column :users, :ios_login, :boolean
  end
end
