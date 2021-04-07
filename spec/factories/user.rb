# frozen_string_literal: true

# fronzen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@movies.com" }
    password { "secret" }

    trait :five_years_old_user do
      birthdate { 5.years.ago.to_date }
    end

    trait :ten_years_old_user do
      birthdate { 10.years.ago.to_date }
    end

    trait :fifteen_years_old_user do
      birthdate { 15.years.ago.to_date }
    end

    trait :nineteen_years_old_user do
      birthdate { 19.years.ago.to_date }
    end
  end
end
