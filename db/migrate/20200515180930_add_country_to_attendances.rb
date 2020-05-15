# frozen_string_literal: true

class AddCountryToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_reference :attendances, :country, null: false, foreign_key: true
  end
end
