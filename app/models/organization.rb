class Organization < ApplicationRecord
  has_many :aid_requests

  validates :name, 
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

  validate :contact_info_given

  validate :contact_info_shared

  def contact_info_given
    unless (contact_phone && !contact_phone.empty?) || (contact_email && !contact_email.empty?) || (street_address && !street_address&.empty?)
      errors.add(:please_include, "either a phone number, email address, and/or street address")
    end
  end

  def contact_info_shared
    unless (street_address && share_address) || (contact_phone && share_phone) || (contact_email && share_email)
      errors.add(:please_share, "at least one form of contact so volunteers may get in touch with you.")
    end
  end
end
