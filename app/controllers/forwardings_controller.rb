# frozen_string_literal: true

class ForwardingsController < ApplicationController
  def new
    link_data = Link.fetch_data_by_digest(digest)
    request_info = Attendances::RequestInfoBuilder.new(request: request).call
    HandleAttendanceWorker.perform_async(link_data[:id], request_info.as_json)

    redirect_to link_data[:url]
  end

  private

  def digest
    params.require(:digest)
  end
end
