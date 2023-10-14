# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot'
require 'geocoder'
require 'faker'

Organization.destroy_all

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

refugee_shelter_names = [
  "Safe Haven Refuge",
  "Hopeful Haven Shelter",
  "Harbor of Safety",
  "Rescue Refuge Center",
  "New Beginnings Shelter",
  "Warmth and Welcome Shelter",
  "Pathway to Peace Refuge",
  "Compassion Corner",
  "Emerald Oasis Shelter",
  "Healing Hearts Haven",
  "Solace Shelter",
  "Bridge to Belonging",
  "Sunrise Sanctuary",
  "Unity Refuge Center",
  "Caring Haven",
  "Serenity Shelter",
  "Community Compass Shelter",
  "Harmony Haven",
  "Sunny Days Refuge",
  "Lighthouse of Hope",
  "Angel's Arms Shelter",
  "Life Renewal Refuge",
  "Comfort Cove Shelter",
  "Refugee Empowerment Center",
  "Graceful Shelter",
  "Tranquil Oasis",
  "Dream Safe Haven",
  "Shelter from the Storm",
  "Open Arms Refuge",
  "Heavenly Harbor",
  "Empathy Haven",
  "Journey to Belonging",
  "Heartwarming Shelter",
  "Sanctuary of Dreams",
  "Beloved Shelter",
  "Recovery Refuge",
  "Hope Bridge Shelter",
  "Peaceful Pathway Shelter",
  "Warm Embrace Refuge",
  "Safe Passage Shelter",
  "Sheltered Serenity",
  "Benevolent Refuge",
  "Radiant Retreat Shelter",
  "Hearts United Haven",
  "Companionship Refuge",
  "Golden Oasis Shelter",
  "Welcome Winds Refuge",
  "Guiding Light Shelter",
  "Promise of Tomorrow Refuge",
  "Homecoming Haven",
  "Bridges of Hope Shelter",
  "Whispering Pines Refuge",
  "New Horizons Shelter",
  "Strength in Unity Haven",
  "Sheltered Hearts Sanctuary",
  "Cherished Dreams Refuge"
]

coordinates_by_city_state = {
  "New York City, NY"=>[40.7127281, -74.0060152],
  "Los Angeles, CA"=>[34.0536909, -118.242766],
  "Chicago, IL"=>[41.8755616, -87.6244212],
  "Houston, TX"=>[29.7589382, -95.3676974],
  "Phoenix, AZ"=>[33.4484367, -112.074141],
  "Philadelphia, PA"=>[39.9527237, -75.1635262],
  "San Antonio, TX"=>[29.4246002, -98.4951405],
  "San Diego, CA"=>[32.7174202, -117.1627728],
  "Dallas, TX"=>[32.7762719, -96.7968559],
  "San Jose, CA"=>[37.3361663, -121.890591],
  "Austin, TX"=>[30.2711286, -97.7436995],
  "Jacksonville, FL"=>[30.3321838, -81.655651],
  "San Francisco, CA"=>[37.7790262, -122.419906],
  "Columbus, OH"=>[39.9622601, -83.0007065],
  "Indianapolis, IN"=>[39.7683331, -86.1583502],
  "Fort Worth, TX"=>[32.753177, -97.3327459],
  "Charlotte, NC"=>[35.2272086, -80.8430827],
  "Seattle, WA"=>[47.6038321, -122.330062],
  "Denver, CO"=>[39.7392364, -104.984862],
  "Washington, D.C., DC"=>[38.8950368, -77.0365427],
  "Boston, MA"=>[42.3554334, -71.060511],
  "El Paso, TX"=>[31.7550511, -106.488234],
  "Nashville, TN"=>[36.1622767, -86.7742984],
  "Oklahoma City, OK"=>[35.4729886, -97.5170536],
  "Las Vegas, NV"=>[36.1672559, -115.148516],
  "Detroit, MI"=>[42.3315509, -83.0466403],
  "Memphis, TN"=>[35.1460249, -90.0517638],
  "Portland, OR"=>[45.5202471, -122.674194],
  "Louisville, KY"=>[38.2542376, -85.759407],
  "Milwaukee, WI"=>[43.0349931, -87.922497],
  "Baltimore, MD"=>[39.2908816, -76.610759],
  "Albuquerque, NM"=>[35.0841034, -106.650985],
  "Tucson, AZ"=>[32.2228765, -110.974847],
  "Fresno, CA"=>[36.7295295, -119.70886126075588],
  "Sacramento, CA"=>[38.5810606, -121.493895],
  "Kansas City, MO"=>[39.100105, -94.5781416],
  "Atlanta, GA"=>[33.7489924, -84.3902644],
  "Long Beach, CA"=>[33.7690164, -118.191604],
  "Mesa, AZ"=>[33.4151005, -111.831455],
  "Virginia Beach, VA"=>[36.8529841, -75.9774183],
  "Raleigh, NC"=>[35.7803977, -78.6390989],
  "Omaha, NE"=>[41.2587459, -95.9383758],
  "Miami, FL"=>[25.7741728, -80.19362],
  "Oakland, CA"=>[37.8044557, -122.271356],
  "Tulsa, OK"=>[36.1563122, -95.9927516],
  "Minneapolis, MN"=>[44.9772995, -93.2654692],
  "Wichita, KS"=>[37.6922361, -97.3375448],
  "New Orleans, LA"=>[29.9759983, -90.0782127],
  "Arlington, TX"=>[32.7355816, -97.1071186],
  "Cleveland, OH"=>[41.4996574, -81.6936772]
}


# KEEP FOR NOW - Used to grab all lat/lon for cities above, need to figure out memoizing or caching perhaps
# Geocoder will freeze in current config 🤬
=begin
coordinates_by_city_state = Hash.new

# cities_and_states.each do |city, state|
#   coordinates = Geocoder.coordinates("#{city}, #{state}")
#   coordinates_by_city_state["#{city}, #{state}"] = coordinates
# end
=end

lat_min_range = -0.29
lat_max_range = 0.29
long_min_range = -0.37
long_max_range = 0.37

1000.times do
  city, state = cities_and_states.sample
  name = refugee_shelter_names.sample
  coordinates = coordinates_by_city_state["#{city}, #{state}"]
  random_lat = rand(lat_min_range..lat_max_range) + coordinates[0]
  random_lon = rand(long_min_range..long_max_range) + coordinates[1]
  FactoryBot.create(:organization, name: name, city: city, state: state, latitude: random_lat, longitude: random_lon)
end