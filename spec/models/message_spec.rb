require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "relationships" do
    it { should belong_to :volunteer }
    it { should belong_to :organization }
  end

  describe "validations" do
    it { should validate_presence_of(:sender) }
    it { should validate_presence_of(:message_body) }
  end
end
