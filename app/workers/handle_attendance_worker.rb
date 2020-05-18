# frozen_string_literal: true

class HandleAttendanceWorker
  include Sidekiq::Worker

  sidekiq_options queue: :attendance

  def perform(link_id, request_info_json)
    link = Link.find(link_id)
    request_info = Attendances::RequestInfo.from_json(request_info_json)
    Attendances::HandleStatsService.new(link: link, request_info: request_info).call
  end
end
