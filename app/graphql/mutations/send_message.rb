# frozen_string_literal: true

module Mutations
  class SendMessage < BaseMutation
    type Types::MessageType
    argument :organization_id, Integer
    argument :volunteer_id, Integer
    argument :message_body, String
    argument :sender, String

    def resolve(organization_id:, volunteer_id:, message_body:, sender:)
      begin 
        organization = Organization.find(organization_id)
        volunteer = Volunteer.find(volunteer_id)
        Message.create!(organization: organization, volunteer: volunteer, message_body: message_body, sender: sender)
      rescue ActiveRecord::RecordNotFound => error
        return GraphQL::ExecutionError.new("Invalid input: #{error.message}")
      rescue ActiveRecord::RecordInvalid => error
        return GraphQL::ExecutionError.new("#{error.message}")
      end
    end
  end
end
