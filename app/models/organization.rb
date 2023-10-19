class Organization < ApplicationRecord
  has_many :aid_requests

  validates :name, 
            # :contact_phone, should be optional
            # :contact_email, should be optional
            # :street_address, should be optional
            # :website, #should be optional
            :city,
            :state,
            :zip,  #make city and state optional, and use zip/geocoder to fetch city and state when not provided?
            :latitude,
            :longitude,
            presence: :true

  validates :share_address,
            :share_phone,
            :share_email,
            inclusion: [true,false]

  validate :contact_info_given

  validate :contact_info_shared

  def contact_info_given
    unless contact_phone || contact_email || street_address
      errors.add(:please_include, "either a phone number, email address, and/or street address")
    end
  end

  def contact_info_shared
    unless share_address || share_phone || share_email
      errors.add(:please_share, "at least one form of contact so volunteers may get in touch with you.")
    end
  end
end
