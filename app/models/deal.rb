class Deal < ActiveRecord::Base
	belongs_to :user #(see notes in user model on why this won't work as currently set up)
	belongs_to :campaign

	delegate :brand, to: :campaign, allow_nil: true
	delegate :brand_image, to: :brand, allow_nil: true
	delegate :time_zone, to: :user, allow_nil: true
end
