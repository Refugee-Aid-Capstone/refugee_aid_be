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
    share_address { false }
    share_phone { false }
    share_email { false }
  end
end
