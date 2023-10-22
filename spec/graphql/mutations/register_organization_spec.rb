require "rails_helper"

RSpec.describe RegisterOrganization do
  xit "creates a new organization when given correct params" do
    query = <<-GRAPHQL
    query createOrg($id: ID!){
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
        }
      }
    }
    GRAPHQL
  end

  xit "does not create a new organization if missing address info" do

  end
end