require 'rails_helper'

RSpec.describe AidRequest, type: :model do
  describe "validations" do
    it { should validate_presence_of(:aid_type) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
end
