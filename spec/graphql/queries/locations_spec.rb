require "rails_helper"

RSpec.describe "Locations query" do
  it "returns unique list of locations of registered orgaizations, ordered by state and city" do
    create_list(:organization, 3, city: "New York City", state: "NY")
    create_list(:organization, 2, city: "Denver", state: "CO")
    create_list(:organization, 2, city: "Cheyenne", state: "WY")
    create_list(:organization, 4, city: "Portland", state: "OR")
    create_list(:organization, 3, city: "Albany", state: "NY")

    query = <<~GQL
      query {
        locations {
          city
          state
        }
      }
    GQL

    expected = {
      "locations" => [
        {
          "city" => "Denver",
          "state" => "CO",
        },
        {
          "city" => "Albany",
          "state" => "NY"
        },
        {
          "city" => "New York City",
          "state" => "NY"
        },
        {
          "city" => "Portland",
          "state" => "OR"
        },
        {
          "city" => "Cheyenne",
          "state" => "WY"
        }
      ]
    }

    result = RefugeeAidBeSchema.execute(query)

    expect(result.dig("data")).to eq(expected)
  end
end