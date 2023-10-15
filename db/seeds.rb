
# AidRequest.destroy_all
# Organization.destroy_all

# KEEP FOR NOW - Used to grab all lat/lon for cities above, need to figure out memoizing or caching perhaps
# Geocoder will freeze in current config 🤬
=begin
coordinates_by_city_state = Hash.new

# cities_and_states.each do |city, state|
#   coordinates = Geocoder.coordinates("#{city}, #{state}")
#   coordinates_by_city_state["#{city}, #{state}"] = coordinates
# end
=end



# 1000.times do
#   city, state = cities_and_states.sample
#   name = refugee_shelter_names.sample
#   coordinates = coordinates_by_city_state["#{city}, #{state}"]
#   random_lat = rand(lat_min_range..lat_max_range) + coordinates[0]
#   random_lon = rand(long_min_range..long_max_range) + coordinates[1]
#   FactoryBot.create(:organization, name: name, city: city, state: state, latitude: random_lat, longitude: random_lon)
# end

# ids = Organization.all.pluck(:id)

# 3000.times do 
#   FactoryBot.create(:aid_request, organization_id: ids.sample)
# end

