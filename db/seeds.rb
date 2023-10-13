# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot'

cities_and_states = [
  ["New York City", "NY"],
  ["Los Angeles", "CA"],
  ["Chicago", "IL"],
  ["Houston", "TX"],
  ["Phoenix", "AZ"],
  ["Philadelphia", "PA"],
  ["San Antonio", "TX"],
  ["San Diego", "CA"],
  ["Dallas", "TX"],
  ["San Jose", "CA"],
  ["Austin", "TX"],
  ["Jacksonville", "FL"],
  ["San Francisco", "CA"],
  ["Columbus", "OH"],
  ["Indianapolis", "IN"],
  ["Fort Worth", "TX"],
  ["Charlotte", "NC"],
  ["Seattle", "WA"],
  ["Denver", "CO"],
  ["Washington, D.C.", "DC"],
  ["Boston", "MA"],
  ["El Paso", "TX"],
  ["Nashville", "TN"],
  ["Oklahoma City", "OK"],
  ["Las Vegas", "NV"],
  ["Detroit", "MI"],
  ["Memphis", "TN"],
  ["Portland", "OR"],
  ["Louisville", "KY"],
  ["Milwaukee", "WI"],
  ["Baltimore", "MD"],
  ["Albuquerque", "NM"],
  ["Tucson", "AZ"],
  ["Fresno", "CA"],
  ["Sacramento", "CA"],
  ["Kansas City", "MO"],
  ["Atlanta", "GA"],
  ["Long Beach", "CA"],
  ["Mesa", "AZ"],
  ["Virginia Beach", "VA"],
  ["Raleigh", "NC"],
  ["Omaha", "NE"],
  ["Miami", "FL"],
  ["Oakland", "CA"],
  ["Tulsa", "OK"],
  ["Minneapolis", "MN"],
  ["Wichita", "KS"],
  ["New Orleans", "LA"],
  ["Arlington", "TX"],
  ["Cleveland", "OH"]
]

500.times do
  city, state = cities_and_states.sample
  coordinates = Geocoder.coordinates("#{city}, #{state}")
  
  FactoryBot.create(:organization, city: city, state: state)
end