FactoryBot.define do
  factory :organization do
    name { "MyString" }
    contact_phone { "MyString" }
    contact_email { "MyString" }
    street_address { "MyString" }
    website { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    latitude { 1.2456 }
    longitude { 2.4564 }
    share_address { false }
    share_phone { false }
    share_email { false }
  end
end
