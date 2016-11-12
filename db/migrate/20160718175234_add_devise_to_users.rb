class AddDeviseToUsers < ActiveRecord::Migration
  def change
    
      ## Database authenticatable
      add_column :users, :email, :string
      add_column :users, :encrypted_password, :string


      #t.string :email,              null: false, default: ""
      #t.string :encrypted_password, null: false, default: ""

      ## Recoverable
	  add_column :users, :reset_password_token, :string
	  add_column :users, :reset_password_sent_at, :datetime

      #t.string   :reset_password_token
      #t.datetime :reset_password_sent_at

      ## Rememberable
      add_column :users, :remember_created_at, :datetime

      #t.datetime :remember_created_at

      ## Trackable
	  add_column :users, :sign_in_count, :integer, default: 0, null: false
	  add_column :users, :current_sign_in_at, :datetime
	  add_column :users, :last_sign_in_at, :datetime
	  add_column :users, :current_sign_in_ip, :inet
	  add_column :users, :last_sign_in_ip, :inet


      #t.integer  :sign_in_count, default: 0, null: false
      #t.datetime :current_sign_in_at
      #t.datetime :last_sign_in_at
      #t.inet     :current_sign_in_ip
      #t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      #t.timestamps null: false
    

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :brands, :confirmation_token,   unique: true
    # add_index :brands, :unlock_token,         unique: true
  end
end
