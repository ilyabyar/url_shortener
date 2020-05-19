# frozen_string_literal: true

module Api
  module V1
    class LinksController < Api::BaseController
      def create
        link = Link.new(link_params)
        response_to_render = if link.process!
                               { json: { url: short_url(digest: link.digest) }, status: :created }
                             else
                               { json: { errors: link.errors.full_messages }, status: :unprocessable_entity }
                             end
        render response_to_render
      end

      def index
        links = Link.all
        render json: LinkSerializer.new(links)
      end

      private

      def link_params
        params.require(:link).permit(:url)
      end
    end
  end
end
