require "rails_helper"

RSpec.describe :volunteer do 
  it "returns one volunteer by id" do
    Volunteer.create!(first_name: "Shelby", last_name: "Jackson", email: "sjackson@example.com", id: 1)

    query = <<~GraphQL
      query getVolunteer($id: ID!) {
        volunteer(id: $id) {
          id
          firstName
          lastName
          email
        }
      }
      GraphQL

    result = RefugeeAidBeSchema.execute(query, variables: { id: 1 })

    expect(result).to be_a(GraphQL::Query::Result)

    expected = {
      "id"=>"1", 
      "firstName"=>"Shelby", 
      "lastName"=>"Jackson", 
      "email"=>"sjackson@example.com"}

    expect(result.dig("data", "volunteer")).to eq(expected)
  end

end