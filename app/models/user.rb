class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable
    
   has_many :carts
   has_many :addresses
   has_many :orders
   has_one :user_cart

   validates :email,   :presence => true


  def self.save_omni_auth_details(auth)
      raw_name = auth.extra.raw_info.name
      name = raw_name.split(" ")
      user = where(email: auth.extra.raw_info.email).first_or_initialize
      #user.first_name = name.first
      #user.last_name = name.last
      user.password ||= Devise.friendly_token[0,20]
      # if auth.info.image.present?
      #   avatar_url = process_uri(auth.info.image)
      #   user.update_attribute(:avatar, URI.parse(avatar_url))
      # end
      # puts "======================================#{auth.info.image}"
      user.uid ||= auth.uid
      user.provider ||= auth.provider
      # user.skip_confirmation!
      user.save
      user
    end
end



