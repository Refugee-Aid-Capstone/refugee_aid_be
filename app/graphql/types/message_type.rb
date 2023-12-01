# frozen_string_literal: true

module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :volunteer_id, Integer, null: false
    field :organization_id, Integer, null: false
    field :message_body, String
    field :sender, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :volunteer, Types::VolunteerType, null: false
    field :organization, Types::OrganizationType, null: false
  end
end
