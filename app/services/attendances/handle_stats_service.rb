# frozen_string_literal: true

module Attendances
  class HandleStatsService
    def initialize(link:, request_info:)
      @link = link
      @request_info = request_info
    end

    def call
      save_attendance
      handle_attendance_stats
    end

    private

    delegate :remote_ip, to: :@request_info

    def save_attendance
      @link.attendances.create!(attendance_data)
    end

    def attendance_data
      { ip: remote_ip, request_info: @request_info.headers, country: country }
    end

    def country
      Geocoding::CountryDetector.new(remote_ip).detect_country
    end

    def handle_attendance_stats
      @link.save_to_redis(ip: remote_ip, country: country)
    end
  end
end
