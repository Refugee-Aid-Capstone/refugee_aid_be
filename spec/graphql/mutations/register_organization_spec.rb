require "rails_helper"

RSpec.describe Mutations::RegisterOrganization do
  context "given valid info" do
    it "creates a new organization, with lat and lon data" do
      expect(Organization.count).to eq(0)

      query = <<~GRAPHQL
      mutation createOrg($name: String!, 
                        $contactPhone: String,
                        $contactEmail: String,
                        $streetAddress: String,
                        $website: String,
                        $city: String!,
                        $state: String!,
                        $zip: String!,
                        $shareAddress: Boolean,
                        $sharePhone: Boolean,
                        $shareEmail: Boolean) {
        registerOrganization(name: $name,
                            contactPhone: $contactPhone,
                            contactEmail: $contactEmail,
                            streetAddress: $streetAddress,
                            website: $website,
                            city: $city,
                            state: $state,
                            zip: $zip,
                            shareAddress: $shareAddress,
                            sharePhone: $sharePhone,
                            shareEmail: $shareEmail) {
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
      GRAPHQL

      variables = {
        name: "Some Name",
        contactPhone: "1234567890",
        contactEmail: "example@test.com",
        streetAddress: "8000 Village Cir W",
        website: "thing.com",
        city: "Roxborough Park",
        state: "CO",
        zip: "80125",
        shareAddress: false,
        shareEmail: true,
        sharePhone: true
      }

      result = RefugeeAidBeSchema.execute(query, variables: variables)
      expect(Organization.count).to eq(1)
      expect(result.dig("data").keys).to eq(["registerOrganization"])
      expect(result.dig("data", "registerOrganization").keys).to eq([
        "id",
        "name",
        "contactPhone",
        "contactEmail",
        "streetAddress",
        "website",
        "city",
        "state",
        "zip",
        "latitude",
        "longitude",
        "shareAddress",
        "sharePhone",
        "shareEmail"
      ])
      org_data = result.dig("data", "registerOrganization")
      expect(org_data["id"].to_i).to eq(Organization.last.id)
      expect(org_data["name"]).to eq("Some Name")
      expect(org_data["contactPhone"]).to eq("1234567890")
      expect(org_data["contactEmail"]).to eq("example@test.com")
      expect(org_data["streetAddress"]).to eq("8000 Village Cir W")
      expect(org_data["website"]).to eq("thing.com")
      expect(org_data["city"]).to eq("Roxborough Park")
      expect(org_data["state"]).to eq("CO")
      expect(org_data["zip"]).to eq("80125")
      expect(org_data["latitude"]).to be_a(Float)
      expect(org_data["longitude"]).to be_a(Float)
      expect(org_data["shareAddress"]).to eq(false)
      expect(org_data["sharePhone"]).to eq(true)
      expect(org_data["shareEmail"]).to eq(true)
    end

    it "creates a new organization even if phone, email, and website are blank" do
      query = <<~GRAPHQL
      mutation createOrg($name: String!, 
                        $contactPhone: String,
                        $contactEmail: String,
                        $streetAddress: String,
                        $website: String,
                        $city: String!,
                        $state: String!,
                        $zip: String!,
                        $shareAddress: Boolean,
                        $sharePhone: Boolean,
                        $shareEmail: Boolean) {
        registerOrganization(name: $name,
                            contactPhone: $contactPhone,
                            contactEmail: $contactEmail,
                            streetAddress: $streetAddress,
                            website: $website,
                            city: $city,
                            state: $state,
                            zip: $zip,
                            shareAddress: $shareAddress,
                            sharePhone: $sharePhone,
                            shareEmail: $shareEmail) {
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
      GRAPHQL

      variables = {
        name: "Some Name",
        contactPhone: "",
        contactEmail: "",
        streetAddress: "8000 Village Cir W",
        website: "",
        city: "Roxborough Park",
        state: "CO",
        zip: "80125",
        shareAddress: false,
        shareEmail: true,
        sharePhone: true
      }

      result = RefugeeAidBeSchema.execute(query, variables: variables)
      expect(Organization.count).to eq(1)
      expect(result.dig("data").keys).to eq(["registerOrganization"])
      expect(result.dig("data", "registerOrganization").keys).to eq([
        "id",
        "name",
        "contactPhone",
        "contactEmail",
        "streetAddress",
        "website",
        "city",
        "state",
        "zip",
        "latitude",
        "longitude",
        "shareAddress",
        "sharePhone",
        "shareEmail"
      ])
      org_data = result.dig("data", "registerOrganization")
      expect(org_data["id"].to_i).to eq(Organization.last.id)
      expect(org_data["name"]).to eq("Some Name")
      expect(org_data["contactPhone"]).to eq("")
      expect(org_data["contactEmail"]).to eq("")
      expect(org_data["streetAddress"]).to eq("8000 Village Cir W")
      expect(org_data["website"]).to eq("")
      expect(org_data["city"]).to eq("Roxborough Park")
      expect(org_data["state"]).to eq("CO")
      expect(org_data["zip"]).to eq("80125")
      expect(org_data["latitude"]).to be_a(Float)
      expect(org_data["longitude"]).to be_a(Float)
      expect(org_data["shareAddress"]).to eq(false)
      expect(org_data["sharePhone"]).to eq(true)
      expect(org_data["shareEmail"]).to eq(true)
    end
  end

  context "given invalid info" do
    it "does not create a new organization if missing city, state, and/or zip" do
      query = <<~GRAPHQL
      mutation createOrg($name: String!, 
                        $contactPhone: String,
                        $contactEmail: String,
                        $streetAddress: String,
                        $website: String,
                        $city: String!,
                        $state: String!,
                        $zip: String!,
                        $shareAddress: Boolean,
                        $sharePhone: Boolean,
                        $shareEmail: Boolean) {
        registerOrganization(name: $name,
                            contactPhone: $contactPhone,
                            contactEmail: $contactEmail,
                            streetAddress: $streetAddress,
                            website: $website,
                            city: $city,
                            state: $state,
                            zip: $zip,
                            shareAddress: $shareAddress,
                            sharePhone: $sharePhone,
                            shareEmail: $shareEmail) {
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
      GRAPHQL

      variables = {
        name: "Some Name",
        contactPhone: "1234567890",
        contactEmail: "example@test.com",
        streetAddress: "8000 Village Cir W",
        website: "thing.com",
        city: "",
        state: "",
        zip: "",
        shareAddress: false,
        shareEmail: true,
        sharePhone: true
      }

      expected = {
        "data"=>{"registerOrganization"=>nil},
        "errors"=>[
          {"message"=>"Validation failed: City can't be blank, State can't be blank, Zip can't be blank", 
          "locations"=>[{"line"=>12, "column"=>3}], 
          "path"=>["registerOrganization"]}
        ]
      }

      result = RefugeeAidBeSchema.execute(query, variables: variables)
      expect(Organization.count).to eq(0)
      expect(result).to eq(expected)
    end

    it "does not create a new organization if no contact info given" do
      query = <<~GRAPHQL
      mutation createOrg($name: String!, 
                        $contactPhone: String,
                        $contactEmail: String,
                        $streetAddress: String,
                        $website: String,
                        $city: String!,
                        $state: String!,
                        $zip: String!,
                        $shareAddress: Boolean,
                        $sharePhone: Boolean,
                        $shareEmail: Boolean) {
        registerOrganization(name: $name,
                            contactPhone: $contactPhone,
                            contactEmail: $contactEmail,
                            streetAddress: $streetAddress,
                            website: $website,
                            city: $city,
                            state: $state,
                            zip: $zip,
                            shareAddress: $shareAddress,
                            sharePhone: $sharePhone,
                            shareEmail: $shareEmail) {
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
      GRAPHQL

      variables = {
        name: "Some Name",
        contactPhone: "",
        contactEmail: "",
        streetAddress: "",
        website: "thing.com",
        city: "Roxborough Park",
        state: "CO",
        zip: "80125",
        shareAddress: false,
        shareEmail: true,
        sharePhone: true
      }

      expected = {
        "data"=>{"registerOrganization"=>nil},
      "errors"=>
        [{
        "message"=>"Validation failed: Please include either a phone number, email address, and/or street address", 
        "locations"=>[{"line"=>12, "column"=>3}], 
        "path"=>["registerOrganization"]}
        ]}
    
      result = RefugeeAidBeSchema.execute(query, variables: variables)
      expect(Organization.count).to eq(0)
      expect(result).to eq(expected)
    end

    it "does not create a new organization if no contact info shared" do
      query = <<~GRAPHQL
      mutation createOrg($name: String!, 
                        $contactPhone: String,
                        $contactEmail: String,
                        $streetAddress: String,
                        $website: String,
                        $city: String!,
                        $state: String!,
                        $zip: String!,
                        $shareAddress: Boolean,
                        $sharePhone: Boolean,
                        $shareEmail: Boolean) {
        registerOrganization(name: $name,
                            contactPhone: $contactPhone,
                            contactEmail: $contactEmail,
                            streetAddress: $streetAddress,
                            website: $website,
                            city: $city,
                            state: $state,
                            zip: $zip,
                            shareAddress: $shareAddress,
                            sharePhone: $sharePhone,
                            shareEmail: $shareEmail) {
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
      GRAPHQL

      variables = {
        name: "Some Name",
        contactPhone: "1234567890",
        contactEmail: "example@test.com",
        streetAddress: "8000 Village Cir W",
        website: "thing.com",
        city: "Roxborough Park",
        state: "CO",
        zip: "80125",
        shareAddress: false,
        shareEmail: false,
        sharePhone: false
      }

      expected = {
        "data"=>{"registerOrganization"=>nil},
        "errors"=> [{
          "message"=>"Validation failed: Please share at least one form of contact so volunteers may get in touch with you.",
          "locations"=>[{"line"=>12, "column"=>3}],
          "path"=>["registerOrganization"]}
        ]}

      result = RefugeeAidBeSchema.execute(query, variables: variables)
      expect(Organization.count).to eq(0)
      expect(result).to eq(expected)
    end
  end
end