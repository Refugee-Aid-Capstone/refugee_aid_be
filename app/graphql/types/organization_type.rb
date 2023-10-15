# frozen_string_literal: true

module Types
  class OrganizationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :contact_phone, String
    field :contact_email, String
    field :street_address, String
    field :website, String
    field :city, String
    field :state, String
    field :zip, String
    field :latitude, Float
    field :longitude, Float
    field :share_address, Boolean
    field :share_phone, Boolean
    field :share_email, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :aid_requests, [Types::AidRequestType], null: false
  end
end
