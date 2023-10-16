require 'rails_helper'

RSpec.describe "Query Types", type: :request do
  describe "Organization" do
    it "returns one Organization by ID" do
      query_string = <<-GRAPHQL
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

      org = create(:organization)
      3.times do
        create(:aid_request, organization: org)
      end

      result = RefugeeAidBeSchema.execute(query_string, variables: { id: org.id})
      response = result["data"]["organization"]
      
      expect(response).to have_key("name")
      expect(response["name"]).to be_a(String)

      expect(response).to have_key("contactPhone")
      expect(response["contactPhone"]).to be_a(String)

      expect(response).to have_key("contactEmail")
      expect(response["contactEmail"]).to be_a(String)

      expect(response).to have_key("streetAddress")
      expect(response["streetAddress"]).to be_a(String)

      expect(response).to have_key("website")
      expect(response["website"]).to be_a(String)

      expect(response).to have_key("city")
      expect(response["city"]).to be_a(String)

      expect(response).to have_key("state")
      expect(response["state"]).to be_a(String)

      expect(response).to have_key("zip")
      expect(response["zip"]).to be_a(String)
      
      expect(response).to have_key("latitude")
      expect(response["latitude"]).to be_a(Float)

      expect(response).to have_key("longitude")
      expect(response["longitude"]).to be_a(Float)

      expect(response).to have_key("shareAddress")
      expect(response["shareAddress"]).to be_in([true, false])

      expect(response).to have_key("sharePhone")
      expect(response["sharePhone"]).to be_in([true, false])

      expect(response).to have_key("shareEmail")
      expect(response["shareEmail"]).to be_in([true, false])
    end
  end
end