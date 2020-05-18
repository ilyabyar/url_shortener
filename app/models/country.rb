# frozen_string_literal: true

class Country < ApplicationRecord
  NOT_DETECTED_NAME = 'Not detected'

  class << self
    def not_detected
      @not_detected ||= Country.find_by!(name: NOT_DETECTED_NAME)
    end

    def all_id_name
      @all_id_name ||= Country.select(:id, :name).each_with_object({}) { |c, accum| accum[c.id] = c.name }
    end
  end
end
