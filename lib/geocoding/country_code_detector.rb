# frozen_string_literal: true

module Geocoding
  class CountryCodeDetector
    def initialize(ip, geocoder: Geocoder)
      @ip = ip
      @geocoder = geocoder
    end

    def detect_country_code
      first_search_result&.country_code
    end

    private

    def country_code
      @country_code ||= first_search_result&.country_code
    end

    def first_search_result
      geocoder_search_ip.first
    end

    def geocoder_search_ip
      @geocoder_search_ip ||= @geocoder.search(@ip)
    end
  end
end
