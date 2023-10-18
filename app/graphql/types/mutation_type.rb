# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_aid_status, Types::AidRequestType do
      argument :id, ID
      argument :status, String
    end

    def update_aid_status(id:, status:)
      begin
        aid_request = AidRequest.find(id)
      rescue ActiveRecord::RecordNotFound => e
        raise GraphQL::ExecutionError.new("Aid Request not found with ID: #{id}")
      end

      if aid_request.status == status
        raise GraphQL::ExecutionError.new("Aid Request status is already #{status}")
      end

      if !AidRequest.statuses.keys.include?(status)
        raise GraphQL::ExecutionError.new("Invalid status: #{status}. Status must be 'pending', 'approved', or 'rejected'.")
      end
      
      aid_request.update(status: status)

      aid_request
    end
  end
end
