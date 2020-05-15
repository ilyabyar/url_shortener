# frozen_string_literal: true

class ForwardingsController < ApplicationController
  def new
    link = Link.find_by!(digest: params[:digest])
    redirect_to link.url
  end
end
