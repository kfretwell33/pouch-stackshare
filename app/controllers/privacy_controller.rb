class PrivacyController < ApplicationController
  def display
  	@show_brand_nav = true
  	@disable_fb_login = true
  end
end
