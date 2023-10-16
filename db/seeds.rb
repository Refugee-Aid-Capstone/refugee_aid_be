require 'csv'

AidRequest.destroy_all
Organization.destroy_all

# KEEP FOR NOW - Used to grab all lat/lon for cities above, need to figure out memoizing or caching perhaps
# Geocoder will freeze in current config 🤬
=begin
coordinates_by_city_state = Hash.new

# cities_and_states.each do |city, state|
#   coordinates = Geocoder.coordinates("#{city}, #{state}")
#   coordinates_by_city_state["#{city}, #{state}"] = coordinates
# end
=end

CSV.foreach(Rails.root.join('db/data/organizations_gen.csv'), headers: true) do |row|
  Organization.create(
    id: row["id"],
    name: row["name"],
    contact_phone: row["contact_phone"],
    contact_email: row["contact_email"],
    street_address: row["street_address"],
    website: row["website"],
    city: row["city"],
    state: row["state"],
    zip: row["zip"],
    latitude: row["latitude"],
    longitude: row["longitude"],
    share_address: row["share_address"],
    share_phone: row["share_phone"],
    share_email: row["share_email"],
    created_at: row["created_at"],
    updated_at: row["updated_at"]
  )
  ActiveRecord::Base.connection.reset_pk_sequence!('organizations')
end

puts "Organizations CSV loaded successfully."

CSV.foreach(Rails.root.join('db/data/aid_requests_gen.csv'), headers: true) do |row|
  AidRequest.create(
    id: row["id"],
    organization_id: row["organization_id"],
    aid_type: row["aid_type"],
    language: row["language"],
    description: row["description"],
    status: row["status"],
    created_at: row["created_at"],
    updated_at: row["updated_at"]
  )
  ActiveRecord::Base.connection.reset_pk_sequence!('aid_requests')
end

puts "Aid Requests CSV loaded successfully."
