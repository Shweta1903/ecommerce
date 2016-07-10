class Address < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name,   :presence => true
  validates :address1, :address2, :city, :contact_number,    :presence => true
end
