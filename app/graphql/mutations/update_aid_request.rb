# frozen_string_literal: true

module Mutations
  class UpdateAidRequest < BaseMutation
    type Types::AidRequestType
    argument :id, ID
    argument :aid_type, String, required: false
    argument :language, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false 

    def resolve(id:, **args)
      aid_request = AidRequest.find(id)
      aid_request.update(args)
      aid_request
    end
  end
end
