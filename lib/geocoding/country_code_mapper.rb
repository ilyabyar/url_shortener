# frozen_string_literal: true

module Geocoding
  class CountryCodeMapper
    def initialize(code, mapper: Carmen::Country)
      @code = code
      @mapper = mapper
    end

    def country_name
      @code && @mapper.alpha_2_coded(@code)&.name
    end
  end
end
