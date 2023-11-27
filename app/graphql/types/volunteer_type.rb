# frozen_string_literal: true

module Types
  class VolunteerType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :email, String
  end
end
