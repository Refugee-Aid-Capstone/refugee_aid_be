require 'rails_helper'

RSpec.describe :organization do
  before do
    @org_1 = create(:organization)
    @aid_1 = create_list(:aid_request, 3, organization: @org_1)
    
    @org_2 = create(:organization)
    @aid_1 = create_list(:aid_request, 2, organization: @org_2)
    
    @orgs = create_list(:organization, 5, city: "Denver", state: "CO")
  end
  
  describe "Happy Path" do
    it "returns one Organization by ID" do
      get_one_organization_query = <<-GRAPHQL
        query getOneOrg($id: ID!){
          organization(id: $id) {
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
      
      result = RefugeeAidBeSchema.execute(get_one_organization_query, variables: { id: @org_1.id })

      expect(result).to be_a(GraphQL::Query::Result)

      result_hash = result.to_h

      expect(result_hash.keys).to contain_exactly("data")
      expect(result_hash["data"]).to be_a(Hash)
      expect(result_hash["data"].keys).to contain_exactly("organization")

      response = result_hash["data"]["organization"]

      expect(response).to be_a(Hash)
      expect(response.keys).to contain_exactly(
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

      expect(response["id"]).to be_a(String)
      expect(response["id"].to_i).to eq(@org_1.id)

      expect(response["name"]).to be_a(String)
      expect(response["contactPhone"]).to be_a(String)
      expect(response["contactEmail"]).to be_a(String)
      expect(response["streetAddress"]).to be_a(String)
      expect(response["website"]).to be_a(String)
      expect(response["city"]).to be_a(String)
      expect(response["state"]).to be_a(String)
      expect(response["zip"]).to be_a(String)
      expect(response["latitude"]).to be_a(Float)
      expect(response["longitude"]).to be_a(Float)
      expect(response["shareAddress"]).to be_in([true, false])
      expect(response["sharePhone"]).to be_in([true, false])
      expect(response["shareEmail"]).to be_in([true, false])
      expect(response["aidRequests"]).to be_an(Array)

      response["aidRequests"].each do |aid_request|
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