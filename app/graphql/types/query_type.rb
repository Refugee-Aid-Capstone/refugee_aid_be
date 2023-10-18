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

    #Organization queries
    field :organization, Types::OrganizationType, null: false do
      argument :id, ID
    end

    def organization(id:)
      Organization.find(id)
    end

    field :organizations, [Types::OrganizationType], null: false do
      argument :city, String 
      argument :state, String
    end

    def organizations(city:, state:)
      Organization.where("city ILIKE ? AND state ILIKE ?", "%#{city}%", "%#{state}%")
    end

    field :organizationsLatLon, [Types::OrganizationType], null: false, description: "Retrieve all organiations within `r` miles of a given lat/lon. The default radius (`r`) is 20 miles." do
      argument :latitude, Float, description: "A latitude coordinate."
      argument :longitude, Float, description: "A longitude coordinate." 
      argument :radius, Integer, required: false, description: "(OPTIONAL) The search radius, in miles, from the provided `latitude` / `longitude`. Default value is 20 miles."
    end

    def organizationsLatLon(latitude:, longitude:, radius:20)
      coordinates = [latitude, longitude]
      Organization.near(coordinates, radius)
    end

    # AidRequests query
    field :aid_requests, [Types::AidRequestType], null: false do
      argument :city, String 
      argument :state, String
    end

    def aid_requests(city:, state:)
      AidRequest.joins(:organization).where("city ILIKE ? AND state ILIKE ?", "%#{city}%", "%#{state}%")
    end

    field :locations, [Types::OrganizationType], null: false

    def locations 
      Organization.select("city", "state").distinct.order("state", "city")
    end
  end
end
