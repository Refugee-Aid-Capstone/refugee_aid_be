require 'rails_helper'

RSpec.describe "Organization Query" do
  before do
    @org_1 = create(:organization)
    3.times do
      create(:aid_request, organization: @org_1)
    end

    @org_2 = create(:organization)
    2.times do
      create(:aid_request, organization: @org_2)
    end

    @orgs = create_list(:organization, 5, city: "Denver", state: "CO")
  end

  describe "Happy Path" do
    it "returns one Organization by ID" do
      result = RefugeeAidBeSchema.execute(get_one_organization_query, variables: { id: @org_1.id })
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
      
      expect(response).to have_key("aidRequests")
      expect(response["aidRequests"]).to be_a(Array)
      response["aidRequests"].each do |aid_request|
        expect(aid_request).to have_key("id")
        expect(aid_request["id"]).to be_a(String)

        expect(aid_request).to have_key("organizationId")
        expect(aid_request["organizationId"]).to be_a(Integer)

        expect(aid_request).to have_key("aidType")
        expect(aid_request["aidType"]).to be_a(String)

        expect(aid_request).to have_key("language")
        expect(aid_request["language"]).to be_a(String)

        expect(aid_request).to have_key("description")
        expect(aid_request["description"]).to be_a(String)

        expect(aid_request).to have_key("status")
        expect(aid_request["status"]).to be_a(String)
      end
    end

    it "returns one Organization by ID" do
      result = RefugeeAidBeSchema.execute(get_organizations_by_city_state, variables: { city: "Denver", state: "CO" })
      response = result["data"]["organizations"]
      
      response.each do |organization|
        expect(organization).to have_key("id")
        expect(organization["id"]).to be_a(String)

        expect(organization).to have_key("name")
        expect(organization["name"]).to be_a(String)

        expect(organization).to have_key("contactPhone")
        expect(organization["contactPhone"]).to be_a(String)

        expect(organization).to have_key("contactEmail")
        expect(organization["contactEmail"]).to be_a(String)

        expect(organization).to have_key("streetAddress")
        expect(organization["streetAddress"]).to be_a(String)

        expect(organization).to have_key("website")
        expect(organization["website"]).to be_a(String)

        expect(organization).to have_key("city")
        expect(organization["city"]).to be_a(String)

        expect(organization).to have_key("state")
        expect(organization["state"]).to be_a(String)

        expect(organization).to have_key("zip")
        expect(organization["zip"]).to be_a(String)
        
        expect(organization).to have_key("latitude")
        expect(organization["latitude"]).to be_a(Float)

        expect(organization).to have_key("longitude")
        expect(organization["longitude"]).to be_a(Float)

        expect(organization).to have_key("shareAddress")
        expect(organization["shareAddress"]).to be_in([true, false])

        expect(organization).to have_key("sharePhone")
        expect(organization["sharePhone"]).to be_in([true, false])

        expect(organization).to have_key("shareEmail")
        expect(organization["shareEmail"]).to be_in([true, false])
        
        expect(organization).to have_key("aidRequests")
        expect(organization["aidRequests"]).to be_a(Array)
      end
    end
  end

  def get_one_organization_query
    <<-GRAPHQL
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
  end

  def get_organizations_by_city_state
    <<-GRAPHQL
      query getAllOrgs($city: String!, $state: String!) {
        organizations(city: $city, state: $state) {
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
  end
end