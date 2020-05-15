# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :link
  belongs_to :country
end
