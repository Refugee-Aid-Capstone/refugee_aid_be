require 'rails_helper'

RSpec.describe "GraphQL Organization Request", type: :request do
  before do
    @org_1 = create(:organization)
    @aid_1 = create_list(:aid_request, 3, organization: @org_1)
    
    @org_2 = create(:organization)
    @aid_1 = create_list(:aid_request, 2, organization: @org_2)
    
    @orgs = create_list(:organization, 5, city: "Denver", state: "CO")
  end
  
  describe "POST" do
    it "gets an Organization by ID" do
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
      
      post graphql_path, params: { query: get_one_organization_query, variables: { id: @org_1.id } }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      expect(json_response.dig(:data, :organization, :aidRequests, 0, :organization, :name)).not_to be_blank
    end
  end
end