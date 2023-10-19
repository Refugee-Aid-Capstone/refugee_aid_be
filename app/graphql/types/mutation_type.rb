# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject

    field :register_organization, mutation: Mutations::RegisterOrganization
  end
end
