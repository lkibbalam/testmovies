# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates :birthdate, presence: true
  validates_inclusion_of :birthdate, in: Date.new(1900)..Date.current

  def age
    now = Date.current
    age = now.year - birthdate.year
    age - (now.yday < birthdate.yday ? -1 : 0)
  end
end
