# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_aid_request, mutation: Mutations::UpdateAidRequest
  end
end
