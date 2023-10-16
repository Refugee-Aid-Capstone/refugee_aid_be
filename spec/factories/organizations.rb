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
    share_address { true }
    share_phone { true }
    share_email { true }
  end
end
