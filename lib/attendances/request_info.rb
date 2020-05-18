# frozen_string_literal: true

module Attendances
  class RequestInfo
    attr_accessor :remote_ip, :headers

    def initialize(headers:, remote_ip:)
      @headers = headers
      @remote_ip = remote_ip
    end

    def as_json
      {
        remote_ip: @remote_ip,
        headers: @headers
      }
    end

    def self.from_json(options)
      new(**options.symbolize_keys)
    end
  end
end
