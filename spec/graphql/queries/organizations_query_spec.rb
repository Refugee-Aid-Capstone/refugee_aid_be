require 'rails_helper'

RSpec.describe "Organization Query" do
  describe "Happy Path" do
    it "returns Organizations by city and state" do
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
  end
end

