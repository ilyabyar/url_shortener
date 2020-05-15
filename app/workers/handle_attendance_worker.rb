# frozen_string_literal: true

class HandleAttendanceWorker
  include Sidekiq::Worker

  def perform(link_id, request_info)
    link = Link.find(link_id)
    request_info = request_info.symbolize_keys
    Attendances::HandleStatsService.new(link: link, request_info: request_info).call
  end
end
