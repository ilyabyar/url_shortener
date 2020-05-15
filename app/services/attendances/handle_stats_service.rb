# frozen_string_literal: true

module Attendances
  class HandleStatsService
    def initialize(link:, request_info:)
      @link = link
      @request_info = request_info
    end

    def call
      save_attendance
    end

    private

    def attendance_data
      { ip: @request_info[:remote_ip], request_info: @request_info[:headers] }
    end

    def save_attendance
      @link.attendances.create!(attendance_data)
    end
  end
end
