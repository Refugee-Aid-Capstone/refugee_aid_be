require "rails_helper"

RSpec.describe "aidRequests query" do
  it "returns all aid_requests for a given city and state" do
    # Create Denver CO test data
    den_orgs = create_list(:organization, 5, city: "Denver", state: "CO")
    den_orgs.each do |org|
      create_list(:aid_request, 2, organization: org)
    end
    
    # Create Aurora CO test data
    aurora_orgs = create_list(:organization, 2, city: "Aurora", state: "CO")
    aurora_orgs.each do |org|
      create_list(:aid_request, 1, organization: org)
    end

    query = <<-GRAPHQL
      query ($city: String!, $state: String!) {
        aidRequests(city: $city, state: $state) {
          id
          organizationId
          aidType
          language
          description
          status
          organization {
            name
            city
            state
          }
        }
      }
    GRAPHQL

    # Verify that it works for Denver
    den_results = RefugeeAidBeSchema.execute(query, variables: { city: "Denver", state: "co"})
    aurora_results = RefugeeAidBeSchema.execute(query, variables: { city: "aurora", state: "co"})

    expect(den_results).to be_a GraphQL::Query::Result
    
    den_result_hash = den_results.to_h
  
    expect(den_result_hash["data"]).to be_a Hash
    expect(den_result_hash.keys).to contain_exactly("data")
    expect(den_result_hash["data"].keys).to contain_exactly("aidRequests")
    
    den_aid_requests = den_result_hash["data"]["aidRequests"]
    aurora_aid_requests = aurora_results.to_h["data"]["aidRequests"] 
    
    expect(den_aid_requests).to be_an Array

    # Return different number of requests based on the city 
    expect(den_aid_requests.length).to eq 10
    expect(aurora_aid_requests.length).to eq 2
    
    # Sample one aid request
    den_aid_request = den_aid_requests.first

    expect(den_aid_request.keys).to contain_exactly(
      "id", 
      "organizationId", 
      "aidType", 
      "language", 
      "description", 
      "status", 
      "organization"
    )

    expect(den_aid_request["id"]).to be_a String
    expect(den_aid_request["organizationId"]).to be_an Integer
    expect(den_aid_request["aidType"]).to be_a String
    expect(den_aid_request["language"]).to be_a String
    expect(den_aid_request["description"]).to be_a String
    expect(den_aid_request["status"]).to be_a String
    expect(den_aid_request["organization"]).to be_a Hash

    den_org = den_aid_request["organization"]

    expect(den_org.keys).to contain_exactly("name", "city", "state")

    expect(den_org["name"]).to be_a String
    expect(den_org["state"]).to be_a String
    expect(den_org["city"]).to be_a String
  end
end
