# frozen_string_literal: true

module Mutations
  class RegisterOrganization < BaseMutation
    null true
    
    type Types::OrganizationType

    argument :name, String, required: true
    argument :contact_phone, String, required: false
    argument :contact_email, String, required: false
    argument :street_address, String, required: true
    argument :website, String, required: false
    argument :city, String, required: true
    argument :state, String, required: true
    argument :zip, String, required: true
    # argument :latitude, Float, required: false
    # argument :longitude, Float, required: false
    argument :share_address, Boolean, required: false
    argument :share_phone, Boolean, required: false
    argument :share_email, Boolean, required: false


    def resolve(name:, contact_phone:, contact_email:, 
                street_address:, website:, city:, 
                state:, zip:, share_address:, share_phone:, share_email:)
      # latitude = contact geocoder api, use given address
      # longitude = contact geocoder api, use given address
      
      Organization.create!(name: name, contact_phone: contact_phone, contact_email: contact_email, street_address: street_address, website: website, city: city, state: state, zip: zip, latitude: latitude, longitude: longitude, share_address: share_address, share_phone: share_phone, share_email: share_email)
    end
  end
end
