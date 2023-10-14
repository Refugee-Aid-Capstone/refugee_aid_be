FactoryBot.define do
  factory :aid_request do
    organization
    aid_type { "MyString" }
    language { "MyString" }
    description { "MyText" }
    status { "MyString" }
  end
end
