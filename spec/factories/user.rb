# frozen_string_literal: true

# fronzen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@movies.com" }
    password { "secret" }
  end
end
