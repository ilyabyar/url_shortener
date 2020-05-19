# frozen_string_literal: true

class Country < ApplicationRecord
  NOT_DETECTED_NAME = 'Not detected'

  validates :name, presence: true

  class << self
    def not_detected
      @not_detected ||= Country.find_by!(name: NOT_DETECTED_NAME)
    end

    def fetch_by_id(id)
      grouped_by_id.fetch(id)
    end

    private

    def grouped_by_id
      @grouped_by_id ||= Country.select(:id, :name).each_with_object({}) { |c, accum| accum[c.id] = c }
    end
  end

  def alpha_2_code(detector: Carmen::Country)
    detector.named(name).alpha_2_code
  end
end
