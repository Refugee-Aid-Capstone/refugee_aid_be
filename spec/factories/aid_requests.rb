FactoryBot.define do
  factory :aid_request do
    organization
    aid_type { "language" }
    language { "Arabic" }
    description { "MyText" }
    status { "active" }
  end
end
