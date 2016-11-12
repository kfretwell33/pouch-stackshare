class Campaign < ActiveRecord::Base
	
  has_many :deals
  has_many :notifications
  belongs_to :brand
  delegate :brand_image, to: :brand, allow_nil: true
  delegate :time_zone, to: :brand
  #delegate :brand_name, to: :brand, allow_nil: true

  validates :campaign_name, presence: true
	validates :campaign_url, presence: true
	validates :expiration_date, presence: true

	# This method associates the attribute ":fb_image" with a file attachment
  has_attached_file :fb_image, 
  styles: {
  	thumb: '100x100>', 
  	square: '200x200#', 
  	medium: '300x300>'}#,

  before_save :extract_dimensions

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :fb_image, :content_type => /\Aimage\/.*\Z/


  # THIS IS FOR DIMENSION CHECKING Helper method to determine whether or not an attachment is an image.
  # @note Use only if you have a generic asset-type model that can handle different file types.
  def image?
    fb_image_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  # Retrieves dimensions for image assets
  # @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    return unless image?
    tempfile = fb_image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.fb_image_width = geometry.width.to_i
      self.fb_image_height = geometry.height.to_i
      puts "HERE IS THE FB_IMAGE_HEIGHT" + fb_image_height.to_s
    end
  end


end
