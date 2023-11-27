require "rails_helper"

RSpec.describe Types::VolunteerType do 
  subject { Types::VolunteerType }
  it { is_expected.to have_field(:id).of_type("ID!")}
  it { is_expected.to have_field(:first_name).of_type("String")}
  it { is_expected.to have_field(:last_name).of_type("String")}
  it { is_expected.to have_field(:email).of_type("String")}
end