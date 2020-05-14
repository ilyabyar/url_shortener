# frozen_string_literal: true

module Api
  module V1
    class LinksController < ApplicationController
      def create
        link = Link.new(link_params)
        link.process!
        render json: LinkSerializer.new(link).serializable_hash
      end

      private

      def link_params
        params.require(:link).permit(:url)
      end
    end
  end
end
