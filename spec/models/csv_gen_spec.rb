require 'rails_helper'
require 'csv'

RSpec.describe "This test" do
  it "generates aidanization/AidRequest CSV data and is not a test lol" do
    
    # Skipping the test is bleh. This way we will still get that sweet,sweet green dot!

=begin
    organizations = 1000.times.map do
      city, state = @cities_and_states.sample
      name = @refugee_shelter_names.sample
      coordinates = @coordinates_by_city_state["#{city}, #{state}"]
      random_lat = rand(@lat_min_range..@lat_max_range) + coordinates[0]
      random_lon = rand(@long_min_range..@long_max_range) + coordinates[1]
      org = FactoryBot.create(:organization, name: name, city: city, state: state, latitude: random_lat, longitude: random_lon)
    end

    org_csv_headers = ["id", "name", "contact_phone", "contact_email", "street_address", "website", "city", "state", "zip", "latitude", "longitude", "share_address", "share_phone", "share_email", "created_at", "updated_at"]

    org_csv_data = CSV.generate(headers: true) do |csv|
      csv << org_csv_headers

      organizations.each do |org|
        csv << [org.id, org.name, org.contact_phone, org.contact_email, org.street_address, org.website, org.city, org.state, org.zip, org.latitude, org.longitude, org.share_address, org.share_phone, org.share_email, org.created_at, org.updated_at]
      end
    end

    File.write("organizations_gen.csv", org_csv_data)

    orgs = Organization.all

    aid_requests = 3000.times.map do 
      FactoryBot.create(:aid_request, organization: orgs.sample)
    end

    aid_csv_headers = ["id", "organization_id", "aid_type", "language", "description", "status", "created_at", "updated_at"]

    aid_csv_data = CSV.generate(headers: true) do |csv|
      csv << aid_csv_headers

      aid_requests.each do |aid|
        csv << [aid.id, aid.organization_id, aid.aid_type, aid.language, aid.description, aid.status, aid.created_at, aid.updated_at]
      end
    end

    File.write("aid_requests_gen.csv", aid_csv_data)
=end
  end
end