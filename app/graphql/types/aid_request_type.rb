# frozen_string_literal: true

module Types
  class AidRequestType < Types::BaseObject
    field :id, ID, null: false
    field :organization_id, Integer, null: false
    field :aid_type, String
    field :language, String
    field :description, String
    field :status, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :organization, Types::OrganizationType, null: false
  end
end
