require 'rails_helper'

describe "GraphQL `aidRequest` Query Request" do
  describe "Happy Path" do
    it "returns all AidRequests for a given city and state" do
      post "/graphql", params: { 
        query: aid_requests_by_city_state, 
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
      # Note: 10 confirmed aid requests created in /spec/rails_helper.rb, but one of the other two randomly generated orgs could be Denver.

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