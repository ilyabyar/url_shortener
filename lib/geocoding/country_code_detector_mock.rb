# frozen_string_literal: true

module Geocoding
  class CountryCodeDetectorMock
    def initialize(_ip); end

    def detect_country_code
      'BY'
    end
  end
end
