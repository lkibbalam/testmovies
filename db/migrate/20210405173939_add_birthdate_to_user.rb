# frozen_string_literal: true

class AddBirthdateToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birthdate, :date, null: false
  end
end
