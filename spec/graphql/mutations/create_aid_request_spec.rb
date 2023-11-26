require "rails_helper"

RSpec.describe Mutations::CreateAidRequest do 
  before do
    @org = create(:organization)
  
    @query = <<~GraphQL
      mutation createAidRequest($organizationId: Int, $aidType: String, $description: String) {
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

    @no_type_query = <<~GraphQL
      mutation createAidRequest($organizationId: Int, $description: String) {
        createAidRequest(organizationId: $organizationId, description: $description) {
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
    
    @no_org_query = <<~GraphQL
      mutation createAidRequest($description: String) {
        createAidRequest(description: $description) {
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

  describe "given valid input" do
    it "Creates an Aid Request for given Organization" do
      expect(@org.aid_requests.count).to eq(0)

      result = RefugeeAidBeSchema.execute(@query, variables: { organizationId: @org.id, aidType: "medical", description: "A random description" })
      expect(@org.aid_requests.count).to eq(1)

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

  describe "given invalid input" do
    it "cannot create Aid Request with invalid Organization ID" do
      bad_id = @org.id - 1
      bad_id_result = RefugeeAidBeSchema.execute(@query, variables: { organizationId: bad_id, aidType: "medical", description: "A random description" })

      expect(bad_id_result.dig("errors", 0, "message")).to eq("Invalid input: Couldn't find Organization with 'id'=#{bad_id}")
      expect(AidRequest.all).to eq([])

      no_id_result = RefugeeAidBeSchema.execute(@no_org_query, variables: { description: "A random description" })
      expect(no_id_result.dig("errors", 0, "message")).to eq("Invalid input: Couldn't find Organization without an ID")

      expect(AidRequest.all).to eq([])
    end
    
    it "cannot create Aid Request with missing or blank parameters" do
      blank_type_result = RefugeeAidBeSchema.execute(@query, variables: { organizationId: @org.id, aidType: "", description: "A random description" })

      expect(blank_type_result.dig("errors", 0, "message")).to eq("Validation failed: Aid type can't be blank")
      expect(AidRequest.all).to eq([])


      no_type_result = RefugeeAidBeSchema.execute(@no_type_query, variables: { organizationId: @org.id, description: "A random description" })
      expect(no_type_result.dig("errors", 0, "message")).to eq("Validation failed: Aid type can't be blank")

      expect(AidRequest.all).to eq([])
    end 
  end
end