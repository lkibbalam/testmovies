# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  def age
    now = Date.current
    age = now.year - birthdate.year
    age -= 1 if now.yday < birthdate.yday
  end
end
