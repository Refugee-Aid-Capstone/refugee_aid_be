FactoryBot.define do
  factory :message do
    volunteer
    organization
    message_body { "MyString" }
    sender { [0,1].sample }
  end
end
