class CampaignsController < ApplicationController
  
before_action :authenticate_brand!, only: [:new, :show, :track]

  def new
  	@show_brand_nav = true
    @campaign = Campaign.new
  end

  def create
    require 'tzinfo'
  	@show_brand_nav = true
    @campaign = Campaign.new(campaign_params)
    @campaign.brand_id = current_brand.id
    #below converts expiration date to correct time factoring in brand's time zone
    @raw_time_zone = ActiveSupport::TimeZone::MAPPING[@campaign.time_zone]
    @brand_tz = TZInfo::Timezone.get(@raw_time_zone) #sets up TZInfo with brand's timezone
    @brand_current_tz = @brand_tz.current_period
    @brand_tz_utc_offset = @brand_current_tz.utc_total_offset
    @brand_expiration_date = (@campaign.expiration_date - @brand_tz_utc_offset)
    @campaign.expiration_date = @brand_expiration_date
    #end of expiration date conversion based on users timezone
  	
    if @campaign.save
  	redirect_to @campaign
    #render plain: params[:campaign].inspect
    else
    render :new
    end
  	#render plain: params[:campaign].inspect 
  end

  def track
    require 'font-awesome-rails'
    @show_brand_nav = true
    if current_brand
      @tracking = Campaign.where("expiration_date > ? AND brand_id = ?", Time.now, current_brand.id).order(created_at: :desc)
      @tracking_expired = Campaign.where("expiration_date < ? AND brand_id = ?", Time.now, current_brand.id).order(created_at: :desc)
    end
  end

  def show
    @show_brand_nav = true
  	#getting data from campaigns table
    @campaign = Campaign.find(params[:id])
    #getting data from deals table to display aggregate data about a campaign
    @deals = Deal.where(campaign_id: @campaign.id)
    #this only works on production - not local, may want to change logic for creating dynamic_url?
    #creating bitly url client, creating URL to shorten, & calling bitly API
    @client = Bitly.client
    @pouch_url = request.base_url + "/campaigns/pouch/" + @campaign.id.to_s
    @shop_url = request.base_url + "/campaigns/shop/" + @campaign.id.to_s
    @campaign_expiration_display = @campaign.expiration_date.in_time_zone(@campaign.time_zone).strftime("%B %d").to_s + " at " + @campaign.expiration_date.in_time_zone(@campaign.time_zone).strftime("%l:%M%P %Z").strip.to_s
    if @campaign.send_date_one
      @campaign_send_date_one_display = @campaign.send_date_one.strftime("%B %d").to_s + " at " + @campaign.send_date_one.strftime("%l:%M%P").strip.to_s
    end
    if @campaign.send_date_two
      @campaign_send_date_two_display = @campaign.send_date_two.strftime("%B %d").to_s + " at " + @campaign.send_date_two.strftime("%l:%M%P").strip.to_s
    end
    @bitly_url = @client.shorten(@shop_url)
  end

  def pouch
    @hide_footer = true
  	@campaign = Campaign.find(params[:id])
    @pouch_url = request.original_url
    if current_user && Time.now < @campaign.expiration_date
      #test if deal already exists in user's Pouch
      @row_exists = Deal.exists?(user_id: current_user.id, campaign_id: @campaign.id)

      @deal = Deal.new
      @deal.uid = current_user.uid
      @deal.campaign_id = @campaign.id
      @deal.display = true
      @deal.user_id = current_user.id
      #below is unnecessary if using associations - leaving in case it's more complicated with swift
      @deal.user_name = current_user.user_name
		  @deal.campaign_name = @campaign.campaign_name
		  @deal.brand_name = @campaign.brand_name
      @deal.brand_id = @campaign.brand_id
      @deal.expiration_date = @campaign.expiration_date
      @deal.campaign_url = @campaign.campaign_url
      #rest of code is necessary
      unless @row_exists
		    @deal.save
        create_notification(@campaign.id, current_user.id, @campaign.alert_one, @campaign.send_date_one)
        create_notification(@campaign.id, current_user.id, @campaign.alert_two, @campaign.send_date_two)
      end
    end
  end

  def shop
    @show_brand_nav = false
    @hide_footer = true
    @disable_fb_login = true
    @campaign = Campaign.find(params[:id])
    @shop_url = request.original_url
    if @campaign.banner_text.blank?
      @campaign.banner_text = "Save this deal with Pouch!"
    end
    if Time.now > @campaign.expiration_date
      #redirect_to @campaign.campaign_url
    else
      if current_user && Time.now < @campaign.expiration_date
      #test if deal already exists in user's Pouch
      @row_exists = Deal.exists?(user_id: current_user.id, campaign_id: @campaign.id)

      @deal = Deal.new
      @deal.uid = current_user.uid
      @deal.campaign_id = @campaign.id
      @deal.display = true
      @deal.user_id = current_user.id
      #below is unnecessary if using associations - leaving incase it's more complicated with swift
      @deal.user_name = current_user.user_name
      @deal.campaign_name = @campaign.campaign_name
      @deal.brand_name = @campaign.brand_name
      @deal.brand_id = @campaign.brand_id
      @deal.expiration_date = @campaign.expiration_date
      @deal.campaign_url = @campaign.campaign_url
      #rest of code is necessary
      unless @row_exists
        @deal.save
        create_notification(@campaign.id, current_user.id, @campaign.alert_one, @campaign.send_date_one)
        create_notification(@campaign.id, current_user.id, @campaign.alert_two, @campaign.send_date_two)
      end
    end
  end


end#close out class

  def create_notification(campaign_id, user_id, alert, send_date)
    if alert && send_date #only want to create a scheduled push notification if brands have filled out that info
      @notification = Notification.new
      @notification.campaign_id = campaign_id
      @notification.user_id = user_id
      @notification.alert = alert
      @notification.send_date = send_date
      @notification.scheduled = false
      @notification.stop_scheduling = false
      @notification.save
    end
  end


  private 
  	def campaign_params
  	 params.require(:campaign).permit(:campaign_name, :campaign_url, :expiration_date, :fb_description, :description, :fb_image, :promo_code, :alert_one, :alert_two, :send_date_one, :send_date_two, :banner_hex_code, :banner_text)
 	  end
end
