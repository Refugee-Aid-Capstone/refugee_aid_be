class Organization < ApplicationRecord
  has_many :aid_requests

  validates :name, 
            :contact_phone, 
            :contact_email, 
            :street_address,
            :website,
            :city,
            :state,
            :zip,
            :latitude,
            :longitude,
            :share_address,
            :share_phone,
            :share_email, presence: :true
end
