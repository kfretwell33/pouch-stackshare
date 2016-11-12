class WelcomeController < ApplicationController

  # GET /welcome
  def index
  
    if current_user
       @data = Deal.where("expiration_date > ? AND user_id = ? AND display = ?", Time.now, current_user.id, true).order(expiration_date: :asc)    
      #time tests
      @time = Time.now
  	elsif current_brand
  		redirect_to campaigns_track_path
  	end
  end



end
