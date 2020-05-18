# frozen_string_literal: true

module UrlProcessing
  module Strategies
    class Escape
      def call(url)
        URI.escape(url) # rubocop:disable Lint/UriEscapeUnescape
      end
    end
  end
end
