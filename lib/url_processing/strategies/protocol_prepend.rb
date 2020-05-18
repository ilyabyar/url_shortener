# frozen_string_literal: true

module UrlProcessing
  module Strategies
    class ProtocolPrepend
      def call(url)
        return url unless URI.parse(url).relative?

        URI::HTTP.build(host: url)
      end
    end
  end
end
