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
      begin
      aid_request = AidRequest.find(id)
      rescue ActiveRecord::RecordNotFound => e
        return GraphQL::ExecutionError.new("Invalid input: #{e.message}")
      end

      if args.values.any?(&:blank?)
        return GraphQL::ExecutionError.new("Invalid input: #{args.select { |arg, value| value.blank? }.keys.join(', ')}")
      end
      
      aid_request.update(args)
      aid_request
    end
  end
end
