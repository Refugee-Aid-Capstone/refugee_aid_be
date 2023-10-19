require 'rails_helper'

RSpec.describe "GraphQL Organizations Request", type: :request do
  before do
    @org_1 = create(:organization)
    @aid_1 = create_list(:aid_request, 3, organization: @org_1)
    
    @org_2 = create(:organization)
    @aid_1 = create_list(:aid_request, 2, organization: @org_2)
    
    @orgs = create_list(:organization, 5, city: "Denver", state: "CO")
  end
  
  describe "POST" do
    it "gets Organizations by city and state" do
      get_organizations_by_city_state = <<-GRAPHQL
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

      post graphql_path, params: { query: get_organizations_by_city_state, variables: { city: "Denver", state: "CO" } }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      expect(json_response.dig(:data, :organizations, 0, :id)).not_to be_blank
    end
  end
end