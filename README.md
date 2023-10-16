# Refugee Aid

Refugee Aid is an app that connects citizens in the United States with refugee aid organizations and camps.

## :clipboard: Table of Contents
[:hammer: Installation](#hammer-installation) | [:question: GraphQL Queries](#question-graphql-queries) | [:people_holding_hands: Authors](#people_holding_hands-authors)

## :hammer: Installation

Install all necessary gem files:
```ruby
bundle install
```

Create, migrate, and seed the PostgresQL database:
```ruby
bundle exec rails db:{create,migrate,seed}
```

Run the test suite to verify that everything works:
```ruby
bundle exec rspec
```

---

## :question: GraphQL Queries

| Types | Description |
| --- | ---|
| [`Organization`](#organization) | The entity requesting aid. |
| [`AidRequest`](#aidrequest) | The aid an organization is requesting. |

#### Organization

```graphql
type Organization {
  id: ID!
  name: String
  city: String
  contactEmail: String
  contactPhone: String
  website: String
  streetAddress: String
  city: String
  state: String
  zip: String
  latitude: Float
  longitude: Float
  shareAddress: Boolean
  shareEmail: Boolean
  sharePhone: Boolean
  aidRequests: [AidRequest]
}
```

#### AidRequest

```graphql
type AidRequest {
  id: ID!
  organizationId: Integer
  aidType: String
  language: String
  description: String
  status: String
  organization: Organization!
}
```


<table>
<tr>
<th width="500px">
<small>Query</small>
</th>
<th width="500px">
<small>
Response
</small>
</th>
</tr>
<tr>
<td>
  
```graphql
{
  organization(id: 1) {
    id                # The organization's ID
    name              # The name of the organization
    contactPhone      # A contact phone number
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
    }
  }
}
```

</td>
<td>

```json
{
  "data": {
    "organization": {
      "id": "1",
      "name": "Welcome Winds Refuge",
      "contactPhone": "1-347-839-2631",
      "contactEmail": "mitchel.schmitt@powlowski.test",
      "streetAddress": "8223 Lou Crest",
      "website": "http://kemmer.test/carita",
      "city": "Oklahoma City",
      "state": "OK",
      "zip": "49131",
      "latitude": 35.653564198354196,
      "longitude": -97.19134672640317,
      "shareAddress": false,
      "sharePhone": true,
      "shareEmail": true,
      "aidRequests": [
        {
          "id": "2000",
          "organizationId": 1,
          "aidType": null,
          "language": "Arabic",
          "description": "MyText",
          "status": null
        },
        {
          "id": "2281",
          "organizationId": 1,
          "aidType": null,
          "language": "Arabic",
          "description": "MyText",
          "status": null
        },
        {
          "id": "2958",
          "organizationId": 1,
          "aidType": null,
          "language": "Arabic",
          "description": "MyText",
          "status": null
        }
      ]
    }
  }
}
```
  
</td>
</tr>
<tr>
<td align="center">
Column 1
</td>
<td align="center">
Column 2
</td>
</tr>
</table>

## :people_holding_hands: Authors

**Refugee Aid** is a student project built in October, 2023 for the Backend Program of the [Turing School of Software and Design](https://turing.edu/).

### Back End Team
- **Ethan Black** ([Github](https://github.com/ethanrossblack) • [LinkedIn](https://www.linkedin.com/in/ethanrossblack/))
- **Davis Weimer** ([Github]() • [LinkedIn]())
- **Artemy Gibson** ([Github]() • [LinkedIn]())

### Front End Team
- **Parvin Sattorova** ([Github]() • [LinkedIn]())
- **Renee Pinna** ([Github]() • [LinkedIn]())
