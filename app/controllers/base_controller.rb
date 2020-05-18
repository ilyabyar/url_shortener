# frozen_string_literal: true

class BaseController < ApplicationController
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def internal_server_error
    render file: "#{Rails.root}/public/500", layout: false, status: :internal_server_error
  end
end
