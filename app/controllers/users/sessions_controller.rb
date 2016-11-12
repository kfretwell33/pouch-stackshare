class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
include Devise::Controllers::Rememberable
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def redirect
    #runs when users click "login to facebook"
    #creates a session URL from the referring page so after logging in, users can return to that url
   
    session[:return_to] = request.referrer
    redirect_to '/users/auth/facebook'
    #puts "HERE IS THE REDIRECT URL" + session[:return_to]
  end
  #end

  def redirect_email
    #creates a session URL from the referring page so after logging in, users can return to that url
   
    session[:return_to] = request.referrer
    redirect_to '/users/sign_in'
    #puts "HERE IS THE REDIRECT URL" + session[:return_to]
  end

  def create     
    self.resource = warden.authenticate!(auth_options)
    remember_me(resource)
    sign_in(resource_name, resource)
    yield resource if block_given?
    #send user to URL they were on before logging in (".delete" destroys that URL from session)
    puts "HERE IS THE REDIRECT URL FROM def create in sessions" + session[:return_to]
    redirect_to session.delete(:return_to)  
  end













  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
