require 'rails_helper'

RSpec.describe :organizations do
  before do
    @org_1 = create(:organization, city: "Albuquerque", state: "NM")
    @aid_1 = create_list(:aid_request, 3, organization: @org_1)

    # Get the Lat/Lon for Denver and NYC
    @denver_lat_lon = Geocoder.search("Denver CO")
    @nyc_lat_lon = Geocoder.search("new york ny")

    # create 2 Denver and 3 NYC test organizations
    create_list(:organization, 2, city: "Denver", state: "CO", latitude: @denver_lat_lon.first.latitude, longitude: @denver_lat_lon.first.longitude)
    create_list(:organization, 3, city: "New York", state: "NY", latitude: @nyc_lat_lon.first.latitude, longitude: @nyc_lat_lon.first.longitude)
  end
  
  describe "Happy Path" do
    it "can return Organizations by city and/or state" do
      get_organizations_by_city_state = <<-GRAPHQL
        query getAllOrgs($city: String!, $state: String!) {
          organizations(city: $city, state: $state) {
            id
            name
            contactPhone
            contactEmail
            streetAddress
            website
            city
            state
            zip
            latitude
            longitude
            shareAddress
            sharePhone
            shareEmail
            aidRequests {
              id
              organizationId
              aidType
              language
              description
              status
              organization {
                name
              }
            }
          }
        }
      GRAPHQL
      
      result = RefugeeAidBeSchema.execute(get_organizations_by_city_state, variables: { city: @org_1.city, state: @org_1.state })

      expect(result).to be_a(GraphQL::Query::Result)

      result_hash = result.to_h

      expect(result_hash.keys).to contain_exactly("data")
      expect(result_hash["data"]).to be_a(Hash)
      expect(result_hash["data"].keys).to contain_exactly("organizations")
      
      response = result_hash["data"]["organizations"]
      
      expect(response).to be_a(Array)
      response.each do |organization|
        expect(organization.keys).to contain_exactly(
          "id", 
          "name", 
          "contactPhone", 
          "contactEmail", 
          "streetAddress", 
          "website", 
          "city", 
          "state", 
          "zip", 
          "latitude", 
          "longitude", 
          "shareAddress", 
          "sharePhone", 
          "shareEmail", 
          "aidRequests"
          )
        expect(organization["id"]).to be_a(String)
        expect(organization["id"].to_i).to eq(@org_1.id)

        expect(organization["name"]).to be_a(String)
        expect(organization["contactPhone"]).to be_a(String)
        expect(organization["contactEmail"]).to be_a(String)
        expect(organization["streetAddress"]).to be_a(String)
        expect(organization["website"]).to be_a(String)
        expect(organization["city"]).to be_a(String)
        expect(organization["state"]).to be_a(String)
        expect(organization["zip"]).to be_a(String)
        expect(organization["latitude"]).to be_a(Float)
        expect(organization["longitude"]).to be_a(Float)
        expect(organization["shareAddress"]).to be_in([true, false])
        expect(organization["sharePhone"]).to be_in([true, false])
        expect(organization["shareEmail"]).to be_in([true, false])
        expect(organization["aidRequests"]).to be_an(Array)

        organization["aidRequests"].each do |aid_request|
          expect(aid_request.keys).to contain_exactly(
            "id",
            "organizationId",
            "aidType",
            "language",
            "description",
            "status",
            "organization"
          )
          expect(aid_request["id"]).to be_a(String)
          expect(aid_request["organizationId"]).to be_a(Integer)
          expect(aid_request["aidType"]).to be_a(String)
          expect(aid_request["language"]).to be_a(String)
          expect(aid_request["description"]).to be_a(String)
          expect(aid_request["status"]).to be_a(String)
          expect(aid_request["organization"]).to be_a(Hash)
        end
      end
    end

    it "can return all organizations within a default radius of 20 miles of a given lat/lon" do
      # Five total organizations
      expect(Organization.count).to eq 6
  
      # Querying with Denver's lat/lon should only include the 2 Denver organizations
      den_results = RefugeeAidBeSchema.execute(
        organizationsLatLon_query, 
        variables: { 
          latitude: @denver_lat_lon.first.latitude, 
          longitude: @denver_lat_lon.first.longitude 
        }
      ).to_h
  
      expect(den_results).to be_a Hash
      expect(den_results.keys).to contain_exactly("data")
      
      expect(den_results["data"]).to be_a Hash
      expect(den_results["data"].keys).to contain_exactly("organizations")
      
      expect(den_results["data"]["organizations"]).to be_an Array
      expect(den_results["data"]["organizations"].length).to eq 2
  
  
      # Querying with NYC's lat/lon should only return the 3 NYC organizations
      nyc_results = RefugeeAidBeSchema.execute(
        organizationsLatLon_query, 
        variables: { 
          latitude: @nyc_lat_lon.first.latitude, 
          longitude: @nyc_lat_lon.first.longitude 
        }
      ).to_h
  
      expect(nyc_results["data"]["organizations"].length).to eq 3
    end
  
    it "returns all organizations within a defined radius length (in miles) for a given lat/lon" do
      # Run a query to get all orgs within 5,000 miles (a purposefully huge number) of Denver 
      huge_results = RefugeeAidBeSchema.execute(
        organizationsLatLon_query, 
        variables: { 
          latitude: @denver_lat_lon.first.latitude, 
          longitude: @denver_lat_lon.first.longitude,
          radius: 5000
        }
      ).to_h
  
      expect(huge_results["data"]["organizations"].length).to eq 6
    end
  end

  def organizationsLatLon_query
    <<~GQL
      query searchOrgsByLatLon
      (
        $latitude: Float!, 
        $longitude: Float!, 
        $radius: Int
      )
      {
        organizations
        (
          latitude: $latitude, 
          longitude: $longitude, 
          radius: $radius
        ) 
        {
          city
          state
        }
      }
    GQL
  end
end

