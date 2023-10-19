# Refugee Aid

Refugee Aid is an app that connects citizens in the United States with refugee aid organizations and camps.

## :clipboard: Table of Contents
- [:hammer: Installation](#hammer-installation)
- [:question: GraphQL Documentation](#question-graphql-documentation)
  - [Queries](#queries)
  - [Types](#types)
- [:people_holding_hands: Authors](#people_holding_hands-authors)

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

## ✍️ GraphQL Queries

The Refuge API is written in [GraphQL](https://graphql.org/).

All queries are done through a `POST` request to the `/graphql` endpoint.

### `organization`

Returns details from a single `Organization` using its unique `id`.

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Query</small>
</th>
<th width="500px">
<small>
🧩 Example Variables
</small>
</th>
</tr>
<tr>
<td>
  
```graphql
query ($id: ID!) {
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
    }
  }
}
```

</td>
<td>

```json
{
  "id": 2
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
```json
{
  "data": {
    "organization": {
      "id": "2",
      "name": "Dream Safe Haven",
      "contactPhone": "1-676-635-1273",
      "contactEmail": "breann.erdman@watsica-durgan.example",
      "streetAddress": "85946 Miller Burg",
      "website": "http://heaney.test/almeta",
      "city": "Philadelphia",
      "state": "PA",
      "zip": "07501-9726",
      "latitude": 40.16353072947562,
      "longitude": -75.29320837398994,
      "shareAddress": true,
      "sharePhone": true,
      "shareEmail": true,
      "aidRequests": [
        {
          "id": "393",
          "organizationId": 2,
          "aidType": "language",
          "language": "Javanese",
          "description": "Dolorem vero maxime quisquam.",
          "status": "pending"
        },
        {
          "id": "891",
          "organizationId": 2,
          "aidType": "legal",
          "language": "Tagalog",
          "description": "Quo et voluptas amet.",
          "status": "active"
        },
        {
          "id": "1006",
          "organizationId": 2,
          "aidType": "language",
          "language": "Romanian",
          "description": "Ea ut qui quos.",
          "status": "active"
        },
        {
          "id": "2350",
          "organizationId": 2,
          "aidType": "medical",
          "language": "Tagalog",
          "description": "Molestiae cumque quisquam quis.",
          "status": "active"
        }
      ]
    }
  }
}
```
</details>
</td>
</tr>
</table>

---

### `organizations`

Returns all `organizations` operating within the provided `city` and `state`.

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Query</small>
</th>
<th width="500px">
<small>
🧩 Example Variables
</small>
</th>
</tr>
<tr>
<td>
  
```graphql
query ($city: String!, $state: String!) {
  organizations(city: $city, state: $state) {
    id
    name
    city
    state
    website
    aidRequests {
      id
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
  "city": "Denver",
  "state": "CO"
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
```json
{
  "data": {
    "organizations": [
      {
        "id": "63",
        "name": "Emerald Oasis Shelter",
        "city": "Denver",
        "state": "CO",
        "website": "http://kub-larkin.test/ramon",
        "aidRequests": [
          {
            "id": "2181",
            "aidType": "other",
            "language": "Hindi",
            "description": "Labore dignissimos deleniti nam.",
            "status": "pending"
          }
        ]
      },
      {
        "id": "97",
        "name": "Life Renewal Refuge",
        "city": "Denver",
        "state": "CO",
        "website": "http://stroman-paucek.example/claudette",
        "aidRequests": [
          {
            "id": "281",
            "aidType": "other",
            "language": "Romanian",
            "description": "Culpa voluptas dolor accusantium.",
            "status": "pending"
          },
          {
            "id": "1333",
            "aidType": "legal",
            "language": "Marathi",
            "description": "Voluptatibus et consequatur laudantium.",
            "status": "active"
          },
          {
            "id": "1527",
            "aidType": "legal",
            "language": "Tagalog",
            "description": "Eos earum nihil commodi.",
            "status": "fulfilled"
          },
          {
            "id": "2993",
            "aidType": "language",
            "language": "Arabic",
            "description": "Modi dolores enim molestiae.",
            "status": "fulfilled"
          }
        ]
      },
      ...
    ]
  }
}

```
</details>
</td>
</tr>
</table>

---

### `organizationsLatLon`

Retrieve all organiations within `r` miles of a given lat/lon. The default radius (`r`) is 20 miles.

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Query</small>
</th>
<th width="500px">
<small>
🧩 Example Variables
</small>
</th>
</tr>
<tr>
<td>
  
```graphql
query searchOrgsByLatLon($latitude: Float!, $longitude: Float!, $radius: Int) {
  organizationsLatLon(latitude: $latitude, longitude: $longitude, radius: $radius) {
    city
    state
  }
}
```

</td>
<td>

```json
{
  "longitude": -104.984862,
  "latitude": 39.7392364,
  "radius": 5000
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
```json
{
  "data": {
    "organization": {
      "id": "2",
      "name": "Dream Safe Haven",
      "contactPhone": "1-676-635-1273",
      "contactEmail": "breann.erdman@watsica-durgan.example",
      "streetAddress": "85946 Miller Burg",
      "website": "http://heaney.test/almeta",
      "city": "Philadelphia",
      "state": "PA",
      "zip": "07501-9726",
      "latitude": 40.16353072947562,
      "longitude": -75.29320837398994,
      "shareAddress": true,
      "sharePhone": true,
      "shareEmail": true,
      "aidRequests": [
        {
          "id": "393",
          "organizationId": 2,
          "aidType": "language",
          "language": "Javanese",
          "description": "Dolorem vero maxime quisquam.",
          "status": "pending"
        },
        {
          "id": "891",
          "organizationId": 2,
          "aidType": "legal",
          "language": "Tagalog",
          "description": "Quo et voluptas amet.",
          "status": "active"
        },
        {
          "id": "1006",
          "organizationId": 2,
          "aidType": "language",
          "language": "Romanian",
          "description": "Ea ut qui quos.",
          "status": "active"
        },
        {
          "id": "2350",
          "organizationId": 2,
          "aidType": "medical",
          "language": "Tagalog",
          "description": "Molestiae cumque quisquam quis.",
          "status": "active"
        }
      ]
    }
  }
}
```
</details>
</td>
</tr>
</table>

---

### `aidRequests`

Returns all `aidRequests` from a provided `city` and `state`.

***Examples***

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Query</small>
</th>
<th width="500px">
<small>
🧩 Example Variables
</small>
</th>
</tr>
<tr>
<td>
  
```graphql
query ($city: String!, $state: String!) {
  aidRequests(city: $city, state: $state) {
    id
    aidType
    language
    description
    status
    organization {
      name
      city
      state
    }
  }
}
```
</td>
<td>

```json
{
  "city": "Denver",
  "state": "CO"
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
```json
{
  "data": {
    "aidRequests": [
      {
        "id": "2181",
        "aidType": "other",
        "language": "Hindi",
        "description": "Labore dignissimos deleniti nam.",
        "status": "pending",
        "organization": {
          "name": "Emerald Oasis Shelter",
          "city": "Denver",
          "state": "CO"
        }
      },
      {
        "id": "281",
        "aidType": "other",
        "language": "Romanian",
        "description": "Culpa voluptas dolor accusantium.",
        "status": "pending",
        "organization": {
          "name": "Life Renewal Refuge",
          "city": "Denver",
          "state": "CO"
        }
      },
      {
        "id": "1333",
        "aidType": "legal",
        "language": "Marathi",
        "description": "Voluptatibus et consequatur laudantium.",
        "status": "active",
        "organization": {
          "name": "Life Renewal Refuge",
          "city": "Denver",
          "state": "CO"
        }
      },
      ...
    ]
  }
}
```
</details>
</td>
</tr>
</table>



## Types

| Types | Description |
| --- | ---|
| [`Organization`](#organization) | The entity requesting aid. |
| [`AidRequest`](#aidrequest) | The aid an organization is requesting. |

#### Organization

```graphql
type Organization {
  id: ID!
  name: String
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


## :people_holding_hands: Authors

**Refugee Aid** is a student project built in October, 2023 for the Backend Program of the [Turing School of Software and Design](https://turing.edu/).

### Back End Team
- **Ethan Black** ([Github](https://github.com/ethanrossblack) • [LinkedIn](https://www.linkedin.com/in/ethanrossblack/))
- **Davis Weimer** ([Github]() • [LinkedIn]())
- **Artemy Gibson** ([Github]() • [LinkedIn]())

### Front End Team
- **Parvin Sattorova** ([Github]() • [LinkedIn]())
- **Renee Pinna** ([Github]() • [LinkedIn]())
