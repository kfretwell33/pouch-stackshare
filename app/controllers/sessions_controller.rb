class SessionsController < ApplicationController
 
  def redirect
    #runs when users click "login to facebook"
    #creates a session URL from the referring page so after logging in, users can return to that url
    session[:return_to] = request.referrer
    redirect_to '/auth/facebook'
  end

  def create     
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    #send user to URL they were on before logging in (".delete" destroys that URL from session)
    redirect_to session.delete(:return_to)   
  end

  def destroy
    session.delete(:user_id)
    #session[:user_id] = nil
    redirect_to root_url
  end


#this method is never used 
  def show
    @user = User.find(params[:id])
    

    #test with data
    @data = Deal.where("expiration_date > ? AND user_id = ? AND display = ?", Time.now, current_user.id, true).order(expiration_date: :asc)    
      #time tests
      @time = Time.now
  end

end