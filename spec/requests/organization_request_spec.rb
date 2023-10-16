require 'rails_helper'

RSpec.describe Types::OrganizationType, type: :request do
  describe "POST" do
    it "gets an Organization by ID" do
      post graphql_path, params: { query: get_one_organization_query, variables: { id: @org_1.id } }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      expect(json_response.dig(:data, :organization, :aidRequests, 0, :organization, :name)).not_to be_blank
    end
    
    it "gets Organizations by city and state" do
      post graphql_path, params: { query: get_organizations_by_city_state, variables: { city: "Denver", state: "CO" } }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      expect(json_response.dig(:data, :organizations, 0, :id)).not_to be_blank
    end
  end
end