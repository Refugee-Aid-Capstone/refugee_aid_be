require 'rails_helper'

RSpec.describe Types::AidRequestType do
  subject { Types::AidRequestType }
  it { is_expected.to have_field(:id).of_type("ID!") }
  it { is_expected.to have_field(:organization_id).of_type("Int!") }
  it { is_expected.to have_field(:aid_type).of_type("String") }
  it { is_expected.to have_field(:language).of_type("String") }
  it { is_expected.to have_field(:description).of_type("String") }
  it { is_expected.to have_field(:status).of_type("String") }
end