require "rails_helper"

RSpec.describe Types::MutationType do
  before do
    @org = create(:organization)
    @aid = create(:aid_request, status: "active", organization: @org)
  
    @query = <<-GQL
      mutation updateAidStatus($id: ID!, $status: String!) {
        updateAidStatus(id: $id, status: $status) {
          id
          status
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
      expect(result.dig("data", "updateStatus", "status")).to eq("pending")
    end
  end

  describe "Sad Path" do
    it "cannot update Aid Request with incorrect ID" do
      result = RefugeeAidBeSchema.execute(@query, variables: { id: "not and ID!", status: "pending" })
      expect(result.dig("errors", 0, "message")).to eq("Aid Request not found with ID: not and ID!")
    end
    
    it "cannot update Aid Request with incorrect status" do
      result = RefugeeAidBeSchema.execute(@query, variables: { id: @aid.id, status: "potatoes" })
      expect(result.dig("errors", 0, "message")).to eq("Invalid status: potatoes. Status must be 'pending', 'approved', or 'rejected'.")
    end 
    
    it "cannot update Aid Request that status matches requested status" do
      result = RefugeeAidBeSchema.execute(@query, variables: { id: @aid.id, status: "active" })
      expect(result.dig("errors", 0, "message")).to eq("Aid Request status is already active")
    end
  end
end