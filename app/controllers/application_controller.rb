  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.



class ApplicationController < ActionController::Base
    #below is testing for json api - just disable for the controller with the API - http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
    protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
    #protect_from_forgery with: :exception (this is what was used before allowing API calls, see line above)
    

    #Enclosed code is when devise was not being used for user login & only facebook-omniauth was being used (now using devise in "users")
        #helper_method :current_user 
        #def current_user
         #current_user ||= User.find(session[:user_id]) if session[:user_id]
        #end
    #End of enclosed code for when devise was not being used for user login & only facebook-omniauth was being used


    


# Code below is for "lazy" way of allowing brands to upload images --> opted to create & edit devise controllers instead & edit the routes file
#before_action :configure_permitted_parameters, if: :devise_controller?
  #protected
  #def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:brand_image])
  #end

end

