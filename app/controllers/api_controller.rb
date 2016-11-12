class ApiController < ApplicationController

	def index
		@users = User.all
	end
	
	def create
	#set user = JSON parameters passed in through API
		@user = User.new(user_params)
		#check if a user with that UID from Faebook already exists
		if @user.uid
			@existing_user = User.exists?(uid: @user.uid, provider: @user.provider)
			facebook_login = true
		else
			if find_user = User.find_by_email(@user.email)
				#puts "HERE IS THE EMAIL ADDRESS" + find_user.email.to_s
				#puts "encrypted_password" + @user.encrypted_password.to_s
				if find_user.valid_password?(@user.encrypted_password) == true
					#puts "VALID PASSWORD"
					@existing_user = true
				else
					#puts "FAILED TO MATCH PASSWORD"
					@existing_user = false #should probably put something else here... some kind of error that "hey, you have an email but the password is incorrect"
				end
			else
				@existing_user = false
			end

			#puts "TRYING TO LOGIN WITH EMAIL"
			facebook_login = false
		end
		#if user exists, just update user_name, oauth_token, & oauth_token expiration date
		if @existing_user && facebook_login == true
			#find row that exists with those parameters
			@update_user = User.find_by(uid: @user.uid, provider: @user.provider)
			respond_to do |format|
				@user.password = Devise.friendly_token[0,20]
				if @update_user.update(user_name: @user.user_name, ios_login: true, fb_timezone: @user.fb_timezone, time_zone: @user.time_zone, email: @user.email) #updating email will throw an error if a facebook user changes their email on facebook to an email address that is already in our database for another user, not sure what the ideal solutin is
					
					
						if @user.device_token != nil
							@update_user.update(device_token: @user.device_token)
						end
					

					
					format.json {render  json: @update_user.as_json(only: [:id, :user_name]), status: :ok}
						else
					format.json {render json: @update_user.errors, status: :unprocessable_entity}
				end
			end
		elsif facebook_login == true 
			#try to save new row
			respond_to do |format|
				@user.password = Devise.friendly_token[0,20]
				@user.ios_login = true
				if @user.save
					format.json {render :show, status: :created, location: @api} 
						else
					format.json {render json: @user.errors, status: :unprocessable_entity}
				end
			end
		elsif @existing_user == true && facebook_login == false
			@update_user = User.find_by(email: @user.email)
			puts "PREPPING TO UPDATE USER WITH EMAIL"
			respond_to do |format|
				if @update_user.update(ios_login: true, time_zone: @user.time_zone)
					
					if @user.device_token != nil
							@update_user.update(device_token: @user.device_token)
						end
					
					format.json {render  json: @update_user.as_json(only: [:id, :user_name]), status: :ok}
				else
						puts "something failed while trying to update user"
						format.json {render json: @update_user.errors, status: :unprocessable_entity}
				end
			end
		elsif @existing_user == false && facebook_login == false
			puts "FAILED TO MATCH EMAIL & PASSWORD"
			puts "HERE IS THE PASSWORD" + @user.encrypted_password.to_s
			respond_to do |format|
				@user.password = @user.encrypted_password
				@user.ios_login = true
				#@user.password_confirmation = @user.encrypted_password
				if @user.save
					format.json {render :show, status: :created, location: @api} 
						else
					format.json {render json: @user.errors, status: :unprocessable_entity}
				end
			end
		else
			puts "ALL OF THE IF LOGIC FAILED & YOU ENDED UP WITH THIS"
			render json: {message: "SOMETHING IS FUCKED"}
		end
	end 

	def show
		@user = User.find(params[:id])
	end

	def deals
		@user = User.find(params[:id])
		@deals = Deal.where("expiration_date > ? AND user_id = ? AND display = ?", Time.now, @user.id, true).order(expiration_date: :asc)
	end 

	def detail
		@deal = Deal.find(params[:id])
	end


	private 
  	def user_params
  	 params.require(:user).permit(:provider, :uid, :time_zone, :user_name, :oauth_token, :oauth_expires_at, :ios_login, :device_token, :fb_timezone, :email, :encrypted_password)
 	  end
end

