FactoryBot.define do
  factory :organization do
    name { "#{Faker::Company.name} #{Faker::Company.suffix}" }
    contact_phone { Faker::PhoneNumber.cell_phone }
    contact_email { Faker::Internet.email }
    street_address { Faker::Address.street_address }
    website { Faker::Internet.url }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip_code }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    share_address { Faker::Boolean.boolean }
    share_phone { Faker::Boolean.boolean }
    share_email { Faker::Boolean.boolean }
  end

  # after :build do |org|
  #   shared = [
  #   org.share_address,
  #   org.share_phone,
  #   org.share_email
  # ]
  #   org.share_email = true if shared.none? {|share| share == true}
  # end
end
