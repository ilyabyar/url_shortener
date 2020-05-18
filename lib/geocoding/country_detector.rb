# frozen_string_literal: true

module Geocoding
  class CountryDetector
    cattr_accessor :desired_strategy

    def initialize(ip, code_mapper: Carmen::Country)
      @ip = ip
      @strategy = build_strategy.new(@ip)
      @code_mapper = code_mapper
    end

    def detect_country
      code = @strategy.detect_country_code
      country_name = @code_mapper.alpha_2_coded(code).name
      find_country(country_name)
    end

    private

    def find_country(country_name)
      Country.find_by!(name: country_name)
    end

    def build_strategy
      self.class.desired_strategy || self.class.default_strategy
    end

    class << self
      def default_strategy
        @default_strategy ||= "Geocoding::#{Rails.configuration.country_detector[:strategy]}".safe_constantize
      end
    end
  end
end
