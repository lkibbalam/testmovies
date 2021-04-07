# frozen_string_literal: true

require "rails_helper"
require "pundit/rspec"

RSpec.describe ::Discover::MoviesPolicy, type: :policy do
  let(:scope) do
    ::Discover::MoviesPolicy::Scope.new(user, DiscoverMovies.new).resolve
  end

  describe "Scope" do
    context "fife years old user" do
      let(:user) { create(:user, :five_years_old_user) }
      it "certification should have only G" do
        expect(scope.send(:options)[:certification]).to eql("G")
      end
    end
    context "ten years old user" do
      let(:user) { create(:user, :ten_years_old_user) }

      it "certification should be eql G|PG" do
        expect(scope.send(:options)[:certification]).to eql("G|PG")
      end
    end

    context "fifteen years old user" do
      let(:user) { create(:user, :fifteen_years_old_user) }

      it "certification should be eql G|PG|PG-13" do
        expect(scope.send(:options)[:certification]).to eql("G|PG|PG-13")
      end
    end

    context "nineteen years old user" do
      let(:user) { create(:user, :nineteen_years_old_user) }

      it "certification should be eql G|PG|PG-13|R" do
        expect(scope.send(:options)[:certification]).to eql("G|PG|PG-13|R")
      end
    end
  end
end
