class User < ActiveRecord::Base
	
	has_many :deals # --> only works if alter relationship to be based on user_id in deals table instead of uid (facebook static user id) OR add in user_id as an additional field on deals table
	has_many :notifications

	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
	
	#NOT USING THIS BECAUSE IT REQUIRES A CHECKBOX ON LOGIN --> INSTEAD USING LOGIC IN CONTROLLERS
    #sets remember_me to true for devise logins so that when users close their browsers, they are still logged in when they visit the site --> if you want to remove the "remember me" checkbox on email login, can comment out this code & use the "remember_me(@user)" methods in the registraion/session/omniauth controllers for "user"
    #def remember_me
    #	(super == nil) ? '1' : super
    #end


	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.user_name = auth.info.name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.fb_timezone = auth.extra.raw_info.timezone
			if auth.info.email.blank?
				user.email = "fake_email_" + auth.uid + "@gmail.com"
			else
				user.email = auth.info.email
			end
    		user.password = Devise.friendly_token[0,20]
			user.save!
		end
	end
end