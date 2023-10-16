FactoryBot.define do
  factory :aid_request do
    organization
    aid_type { AidRequest.aid_types.keys.sample }
    language { Faker::Nation.language }
    description { Faker::Lorem.sentence }
    status { AidRequest.statuses.keys.sample }
  end
end
