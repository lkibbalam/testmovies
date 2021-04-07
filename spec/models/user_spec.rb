# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:birthdate) }
    it { should validate_inclusion_of(:birthdate).in_range(Date.new(1850)..Date.current) }
  end

  describe "#age" do
    context "when the birthday yday is 1 day behind current yday" do
      let(:user) { create(:user, birthdate: Date.ordinal(Date.current.year - 18, Date.current.yday - 1)) }
      it "user age should 18" do
        expect(user.age).to eq(18)
      end
    end

    context "when the birthday yday is same to current yday" do
      let(:user) { create(:user, birthdate: Date.ordinal(Date.current.year - 18, Date.current.yday)) }
      it "user age should 18" do
        expect(user.age).to eq(18)
      end
    end

    context "when the birthday yday is 1 day ahead current yday" do
      let(:user) { create(:user, birthdate: Date.ordinal(Date.current.year - 18, Date.current.yday + 1)) }
      it "user age should be 17" do
        expect(user.age).to eq(17)
      end
    end
  end
end
