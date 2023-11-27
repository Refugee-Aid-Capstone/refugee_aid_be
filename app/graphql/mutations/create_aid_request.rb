# frozen_string_literal: true

module Mutations
  class CreateAidRequest < BaseMutation
    type Types::AidRequestType
    argument :organization_id, Integer, required: false
    argument :aid_type, String, required: false
    argument :language, String, required: false
    argument :description, String, required: false

    def resolve(organization_id: nil, **args)
      begin 
        organization = Organization.find(organization_id)
        organization.aid_requests.create!(args)
      rescue ActiveRecord::RecordNotFound => error
        return GraphQL::ExecutionError.new("Invalid input: #{error.message}")
      rescue ActiveRecord::RecordInvalid => error
        return GraphQL::ExecutionError.new("#{error.message}")
      end
    end
  end
end
