# frozen_string_literal: true

module Geocoding
  class CountryCodeDetectorRandomMock
    SOME_COUNTRIES = %w[BY US AU LT LV RU BA BE BI].freeze

    def initialize(_ip); end

    def detect_country_code
      SOME_COUNTRIES.sample
    end
  end
end
