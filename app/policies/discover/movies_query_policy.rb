# frozen_string_literal: true

module Discover
  class MoviesQueryPolicy < ApplicationPolicy
    class Scope
      def initialize(user, scope)
        @user  = user
        @scope = scope
      end

      def resolve
        if user.age <= 5
          scope.where(certification: "G")
        elsif user.age.between?(6, 13)
          scope.where(certification: "G|PG")
        elsif user.age.between?(14, 17)
          scope.where(certification: "G|PG|PG-13")
        elsif user.age >= 18
          scope.where(certification: "G|PG|PG-13|R")
        end
      end

      private

      attr_reader :user, :scope
    end
  end
end
