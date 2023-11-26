# frozen_string_literal: true

module Mutations
  class CreateAidRequest < BaseMutation
    type Types::AidRequestType
    # argument :id, ID
    argument :organization_id, Integer
    argument :aid_type, String
    argument :language, String, required: false
    argument :description, String, required: false
    # argument :status, String, required: false 


    def resolve(**args)
      # begin 
        aid_request = AidRequest.create!(args)
      # rescue  
      # end
      # raise GraphQL::ExecutionError.new "Error creating aid_request", extensions: aid_request.errors.to_hash unless aid_request.save
    end
  end
end
