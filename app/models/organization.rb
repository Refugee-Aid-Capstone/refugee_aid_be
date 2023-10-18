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
            presence: :true

  validates :share_address,
            :share_phone,
            :share_email,
            inclusion: [true,false]

  geocoded_by :address

  def address
    [street, city, state, zip].compact.join(', ')
  end
end
