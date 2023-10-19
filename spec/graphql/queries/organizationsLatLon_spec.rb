require "rails_helper"

RSpec.describe "organizationsLatLon Query" do
  before do
    # Get the Lat/Lon for Denver and NYC
    @denver_lat_lon = Geocoder.search("Denver CO")
    @nyc_lat_lon = Geocoder.search("new york ny")

    # create 2 Denver and 3 NYC test organizations
    create_list(:organization, 2, city: "Denver", state: "CO", latitude: @denver_lat_lon.first.latitude, longitude: @denver_lat_lon.first.longitude)
    create_list(:organization, 3, city: "New York", state: "NY", latitude: @nyc_lat_lon.first.latitude, longitude: @nyc_lat_lon.first.longitude)
  end
  
  it "returns all organizations within a default radius of 20 miles of a given lat/lon" do
    # Five total organizations
    expect(Organization.count).to eq 5

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
    expect(den_results["data"].keys).to contain_exactly("organizationsLatLon")
    
    expect(den_results["data"]["organizationsLatLon"]).to be_an Array
    expect(den_results["data"]["organizationsLatLon"].length).to eq 2


    # Querying with NYC's lat/lon should only return the 3 NYC organizations
    nyc_results = RefugeeAidBeSchema.execute(
      organizationsLatLon_query, 
      variables: { 
        latitude: @nyc_lat_lon.first.latitude, 
        longitude: @nyc_lat_lon.first.longitude 
      }
    ).to_h

    expect(nyc_results["data"]["organizationsLatLon"].length).to eq 3
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

    expect(huge_results["data"]["organizationsLatLon"].length).to eq 5
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
        organizationsLatLon
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