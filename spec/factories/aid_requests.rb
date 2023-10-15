FactoryBot.define do
  factory :aid_request do
    organization
    aid_type { AidRequest.aid_types.keys.sample.to_sym }
    language { "Arabic" }
    description { "MyText" }
    status { AidRequest.statuses.keys.sample.to_sym }
  end
end
