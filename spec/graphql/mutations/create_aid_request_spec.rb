require "rails_helper"

RSpec.describe Mutations::CreateAidRequest do 
  before do
    @org = create(:organization)
  
    @query = <<~GraphQL
      mutation createAidRequest($organizationId: Int!, $aidType: String!, $description: String) {
        createAidRequest(organizationId: $organizationId, aidType: $aidType, description: $description) {
          id
          aidType
          language
          description
          status
          organization {
            name
            id
          } 
        }
      }
    GraphQL
  end

  describe "Happy Path" do
    it "Creates an Aid Request for given Organization" do
      expect(@org.aid_requests.count).to eq(0)

      result = RefugeeAidBeSchema.execute(@query, variables: { organizationId: @org.id, aidType: "medical", description: "A random description" })

      request = result.dig("data", "createAidRequest")
      expect(request.keys).to eq(["id", "aidType", "language", "description", "status", "organization"])
      expect(request["aidType"]).to eq("medical")
      expect(request["language"]).to eq(nil)
      expect(request["description"]).to eq("A random description")
      expect(request["status"]).to eq("active")
      expect(request["organization"].keys).to eq(["name", "id"])
      expect(request["organization"]["id"]).to eq(@org.id.to_s)
    end
  end

  describe "Sad Path" do
    xit "cannot create Aid Request with non-existing Organization ID" do


      # result = RefugeeAidBeSchema.execute(@query, variables: { id: "not and ID!", status: "pending" })
      # expect(result.dig("errors", 0, "message")).to eq("Invalid input: Couldn't find AidRequest with 'id'=not and ID!")
    end
    
    xit "cannot create Aid Request with missing parameters" do

      
      # result = RefugeeAidBeSchema.execute(@multiple_attr_query, variables: { id: @aid.id, language: "", status: ""})
      # expect(result.dig("errors", 0,  "message")).to eq("Invalid input: language, status")
    end 

    xit "cannot create Aid Request with blank parameters" do

    end
  end
end