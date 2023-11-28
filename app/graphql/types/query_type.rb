# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # Organization details by ID
    field :organization, Types::OrganizationType, null: false do
      argument :id, ID
    end

    def organization(id:)
      Organization.find(id)
    end

    # Organizations for a given city+state
    field :organizations, [Types::OrganizationType], null: false do
      argument :city, String 
      argument :state, String
    end

    def organizations(city:, state:)
      Organization.where("city ILIKE ? AND state ILIKE ?", "%#{city}%", "%#{state}%")
    end

    # AidRequests for a given city+state
    field :aid_requests, [Types::AidRequestType], null: false do
      argument :city, String 
      argument :state, String
    end

    def aid_requests(city:, state:)
      AidRequest.joins(:organization).where("city ILIKE ? AND state ILIKE ?", "%#{city}%", "%#{state}%")
    end

    # All locations sorted by state, alphabetically
    field :locations, [Types::OrganizationType], null: false

    def locations 
      Organization.select("city", "state").distinct.order("state", "city")
    end

    field :volunteer, Types::VolunteerType, null: false do
      argument :id, ID
    end

    def volunteer(id:)
      Volunteer.find(id)
    end

    field :messages, [Types::MessageType], null: false do
      argument :volunteer_id, Integer
      argument :organization_id, Integer
    end

    def messages(volunteer_id:, organization_id:)
      Message.where(volunteer_id: volunteer_id, organization_id: organization_id).order(:created_at)
    end
  end
end
