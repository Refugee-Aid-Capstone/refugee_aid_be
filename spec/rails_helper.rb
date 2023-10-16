# This file is copied to spec/ when you run 'rails generate rspec:install'
require "simplecov"
SimpleCov.start
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods

  # necessary data for CSV generation
  config.before do
    @cities_and_states = [
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

    @refugee_shelter_names = [
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

    @coordinates_by_city_state = {
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

    @lat_min_range = -0.29
    @lat_max_range = 0.29
    @long_min_range = -0.37
    @long_max_range = 0.37

    def get_one_organization_query
      <<-GRAPHQL
        query getOneOrg($id: ID!){
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
              organization {
                name
              }
            }
          }
        }
      GRAPHQL
    end
  
    def get_organizations_by_city_state
      <<-GRAPHQL
        query getAllOrgs($city: String!, $state: String!) {
          organizations(city: $city, state: $state) {
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
              organization {
                name
              }
            }
          }
        }
      GRAPHQL
    end

    @org_1 = create(:organization)
    3.times do
      create(:aid_request, organization: @org_1)
    end

    @org_2 = create(:organization)
    2.times do
      create(:aid_request, organization: @org_2)
    end

    @orgs = create_list(:organization, 5, city: "Denver", state: "CO")
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end