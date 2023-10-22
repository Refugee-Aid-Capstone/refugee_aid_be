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
    field :organization, Types::OrganizationType, null: false, description: "Fetches an Organization by its ID." do
      argument :id, ID
    end

    def organization(id:)
      Organization.find(id)
    end

    # Organizations for a given city+state
    field :organizations, [Types::OrganizationType], null: false do
      argument :city, String, required: false, description: "The organization's city."
      argument :state, String, required: false, description: "The organizaion's state, in a two-letter postal code."
      argument :latitude, Float, required: false, description: "A latitude coordinate."
      argument :longitude, Float, required: false, description: "A longitude coordinate." 
      argument :radius, Integer, required: false, description: "The search radius, in miles, from the provided `latitude` / `longitude`. Default value is 20 miles."
      argument :location, String, required: false, description: "A flexible search endpoint that accepts any kind of location data (address, city, state, etc.) to search for nearby organizations in our database. Uses an external location API for search functionality."
    end

    def organizations(radius: 20, **args)
      if args[:latitude] && args[:longitude]
        coordinates = [args[:latitude], args[:longitude]]
        Organization.near(coordinates, radius)
      elsif args[:city] || args[:state]
        Organization.where("city ILIKE ? AND state ILIKE ?", "%#{args[:city]}%", "%#{args[:state]}%")
      elsif args[:location]
        geo_data = Geocoder.search(args[:location]).first
        if !geo_data.nil?
          Organization.near(geo_data.coordinates, radius)
        end
      end
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
  end
end
