class Notification < ActiveRecord::Base
	belongs_to :campaign
	belongs_to :user

	delegate :campaign_name, to: :campaign, allow_nil: true
	delegate :campaign_url, to: :campaign, allow_nil: true
	delegate :description, to: :campaign, allow_nil: true
	delegate :expiration_date, to: :campaign, allow_nil: true
	delegate :promo_code, to: :campaign, allow_nil: true

	delegate :brand, to: :campaign, allow_nil: true #telling it to look to the campaign table for any searches related to brand
	delegate :brand_image, to: :brand, allow_nil: true #telling it what variable to look for on the brand table
	
	delegate :device_token, to: :user, allow_nil: true

	delegate :time_zone, to: :user, allow_nil: true
	delegate :fb_timezone, to: :user, allow_nil: true

end
