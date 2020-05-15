# frozen_string_literal: true

module Geocoding
  class CountryDetector
    def initialize(ip, adapter: CountryCodeDetector, code_mapper: CountryCodeMapper)
      @ip = ip
      @adapter = adapter.new(@ip)
      @code_mapper = code_mapper
    end

    def detect_country
      code = @adapter.detect_country_code
      country_name = @code_mapper.new(code).country_name
      find_country(country_name)
    end

    private

    def find_country(country_name)
      country_name ? Country.find_by!(name: country_name) : fallback_country
    end

    def fallback_country
      Country.not_detected
    end
  end
end
