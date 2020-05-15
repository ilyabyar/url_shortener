# frozen_string_literal: true

class Country < ApplicationRecord
  NOT_DETECTED_NAME = 'Not detected'

  class << self
    def not_detected
      @not_detected ||= Country.find_by!(name: NOT_DETECTED_NAME)
    end
  end
end
