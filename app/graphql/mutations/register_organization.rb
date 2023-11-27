# frozen_string_literal: true

module Mutations
  class RegisterOrganization < BaseMutation
    null true
    
    type Types::OrganizationType

    argument :name, String, required: true
    argument :contact_phone, String, required: false
    argument :contact_email, String, required: false
    argument :street_address, String, required: false
    argument :website, String, required: false
    argument :city, String, required: true
    argument :state, String, required: true
    argument :zip, String, required: true
    argument :share_address, Boolean, required: false
    argument :share_phone, Boolean, required: false
    argument :share_email, Boolean, required: false


    def resolve(**args)
      location = Geocoder.search(address(args))
      args[:latitude] = location.first.latitude
      args[:longitude] = location.first.longitude
      begin
        Organization.create!(args)
      rescue ActiveRecord::RecordInvalid => error
        raise GraphQL::ExecutionError, "#{error.message}"
      end
    end

    def address(args)
      [args[:street_address], args[:city], args[:state], args[:zip]].compact.join(', ')
    end
  end
end
