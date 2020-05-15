# frozen_string_literal: true

module Attendances
  class RequestInfo
    RAILS_INTERNAL_HEADERS_SYM = '.'

    def initialize(request:)
      @request = request
    end

    def as_json
      {
        remote_ip: @request.remote_ip,
        headers: all_headers
      }
    end

    private

    def all_headers
      @request.headers.env.reject { |key| internal_header?(key) }
    end

    def internal_header?(name)
      name.to_s.include?(RAILS_INTERNAL_HEADERS_SYM)
    end
  end
end
