require 'rails_helper'

RSpec.describe Types::OrganizationType do
  subject { Types::OrganizationType }
  it { is_expected.to have_field(:id).of_type("ID!") }
  it { is_expected.to have_field(:name).of_type("String") }
  it { is_expected.to have_field(:contact_phone).of_type("String") }
  it { is_expected.to have_field(:contact_email).of_type("String") }
  it { is_expected.to have_field(:street_address).of_type("String") }
  it { is_expected.to have_field(:website).of_type("String") }
  it { is_expected.to have_field(:city).of_type("String") }
  it { is_expected.to have_field(:state).of_type("String") }
  it { is_expected.to have_field(:zip).of_type("String") }
  it { is_expected.to have_field(:latitude).of_type("Float") }
  it { is_expected.to have_field(:longitude).of_type("Float") }
  it { is_expected.to have_field(:share_address).of_type("Boolean") }
  it { is_expected.to have_field(:share_phone).of_type("Boolean") }
  it { is_expected.to have_field(:share_email).of_type("Boolean") }
end