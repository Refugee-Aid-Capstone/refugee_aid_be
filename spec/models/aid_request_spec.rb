require 'rails_helper'

RSpec.describe AidRequest, type: :model do
  describe "validations" do
    it { should validate_presence_of(:aid_type) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it do
      should define_enum_for(:aid_type)
        .with_values([:medical, :language, :food, :legal, :other])
    end
    it do
      should define_enum_for(:status)
        .with_values([:active, :pending, :fulfilled])
    end
  end
end
