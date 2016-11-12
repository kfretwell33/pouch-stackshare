class Brand < ActiveRecord::Base
  
  has_many :campaigns
  has_many :deals, through: :campaigns


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :brand_image, presence: true
  validates :brand_name, presence: true
  validates :time_zone, presence: true

  # This method associates the attribute ":fb_image" with a file attachment
  has_attached_file :brand_image, 
  styles: {
  	thumb: '100x100>',
    extra_small: '150x150>', 
    small: '200x200>', 
  	square: '200x200#', 
  	medium: '300x300>',
    large: '500x500>',
    extra_large: '600x600>',
    gigantic: '750x750>' },
    :s3_protocol => 'https'


  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :brand_image, :content_type => /\Aimage\/.*\Z/
end
