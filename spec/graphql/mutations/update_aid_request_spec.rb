require "rails_helper"

RSpec.describe Mutations::UpdateAidRequest do
  before do
    @org = create(:organization)
    @aid = create(:aid_request, status: "active", organization: @org)
  
    @query = <<-GQL
      mutation updateAidRequest($id: ID!, $status: String) {
        updateAidRequest(id: $id, status: $status) {
          id
          status
          organization {
            name
            id
          } 
        }
      }
    GQL

    @multiple_attr_query = <<-GQL
      mutation updateAidRequest($id: ID!, $language: String, $status: String) {
        updateAidRequest(id: $id, language: $language, status: $status) {
          id
          status
          language
          organization {
            name
            id
          }
        }
      }
    GQL
  end

  describe "Happy Path" do
    it "updates the status of the Aid Request" do
      result = RefugeeAidBeSchema.execute(@query, variables: { id: @aid.id, status: "pending" })
      expect(result.dig("data", "updateAidRequest", "status")).to eq("pending")
    end

    it "updates the status and language of the Aid Request" do
      result = RefugeeAidBeSchema.execute(@multiple_attr_query, variables: { id: @aid.id, status: "pending", language: "French" })
      expect(result.dig("data", "updateAidRequest", "status")).to eq("pending")
      expect(result.dig("data", "updateAidRequest", "language")).to eq("French")
    end
  end

  describe "Sad Path" do
    it "cannot update Aid Request with incorrect ID" do
      result = RefugeeAidBeSchema.execute(@query, variables: { id: "not and ID!", status: "pending" })
      expect(result.dig("errors", 0, "message")).to eq("Invalid input: Couldn't find AidRequest with 'id'=not and ID!")
    end
    
    it "cannot update Aid Request with blank parameters" do
      result = RefugeeAidBeSchema.execute(@multiple_attr_query, variables: { id: @aid.id, language: "", status: ""})
      expect(result.dig("errors", 0,  "message")).to eq("Invalid input: language, status")
    end 
  end
end