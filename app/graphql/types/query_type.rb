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
      # argument :city, String, required: false 
      # argument :state, String, required: false
      # argument :latitude, Float, required: false, description: "A latitude coordinate."
      # argument :longitude, Float, required: false, description: "A longitude coordinate." 
      argument :radius, Integer, required: false, description: "(OPTIONAL) The search radius, in miles, from the provided `latitude` / `longitude`. Default value is 20 miles."
      argument :location, String, required: false
    end

    def organizations(radius: 20, **args)
      data = Geocoder.search(args[:location]).first
      # require "pry"; binding.pry
      results = Organization.near(data.coordinates, radius)
      require "pry"; binding.pry
      results
      # # require "pry"; binding.pry
      # if args[:latitude] && args[:longitude]
      #   coordinates = [args[:latitude], args[:longitude]]
      #   # require "pry"; binding.pry
      #   Organization.near(coordinates, radius)
      # else
      #   Organization.where("city ILIKE ? AND state ILIKE ?", "%#{args[:city]}%", "%#{args[:state]}%")
      # end
    end

    # def organizationsLatLon(latitude:, longitude:, radius:20)
    #   coordinates = [latitude, longitude]
    #   Organization.near(coordinates, radius)
    # end

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
