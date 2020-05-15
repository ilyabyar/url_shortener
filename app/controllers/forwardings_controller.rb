# frozen_string_literal: true

class ForwardingsController < ApplicationController
  def new
    link = Link.find_by!(digest: params[:digest])
    request_json_dump = Attendances::RequestInfo.new(request: request).as_json
    HandleAttendanceWorker.perform_async(link.id, request_json_dump)

    redirect_to link.url
  end
end
