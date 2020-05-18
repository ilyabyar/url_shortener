# frozen_string_literal: true

class ForwardingsController < ApplicationController
  def new
    link = Link.find_by!(digest: params[:digest])
    request_info = Attendances::RequestInfoBuilder.new(request: request).call
    HandleAttendanceWorker.perform_async(link.id, request_info.as_json)

    redirect_to link.url
  end
end
