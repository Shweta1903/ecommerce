class Category < ActiveRecord::Base
	has_many :products
	mount_uploader :thumbnail, ThumbnailUploader

	validates :name,   :presence => true
end
