require 'rails_helper'

describe "GraphQL `aidRequest` Request" do
  describe "Happy Path" do
    it "returns all AidRequests for a given city and state" do
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


      post "/graphql", params: { 
        query: query, 
        variables: { city: "Denver", state: "CO" } 
      }

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a Hash
      expect(json_response.keys).to contain_exactly(:data)

      query_data = json_response[:data]

      expect(query_data).to be_a Hash
      expect(query_data.keys).to contain_exactly(:aidRequests)

      aid_requests = query_data[:aidRequests]

      expect(aid_requests).to be_an Array
      expect(aid_requests.length).to be >= 10

      aid_request = aid_requests.first

      expect(aid_request).to be_a Hash
      expect(aid_request.keys).to contain_exactly(:id, :organizationId, :aidType, :language, :description, :status, :organization)

      expect(aid_request[:id]).to be_a String
      expect(aid_request[:organizationId]).to be_an Integer
      expect(aid_request[:aidType]).to be_a String
      expect(aid_request[:language]).to be_a String
      expect(aid_request[:description]).to be_a String
      expect(aid_request[:status]).to be_a String
      expect(aid_request[:organization]).to be_a Hash

      aid_organization = aid_request[:organization]

      expect(aid_organization.keys).to contain_exactly(:name, :city, :state)

      expect(aid_organization[:name]).to be_a String
      expect(aid_organization[:state]).to be_a String
      expect(aid_organization[:city]).to be_a String
    end
  end

  describe "Sad Path" do
    xit "returns error messages" do
      
    end
  end
end
