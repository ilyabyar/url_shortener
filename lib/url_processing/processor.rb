# frozen_string_literal: true

module UrlProcessing
  class Processor
    def initialize(url, strategies: nil)
      @initial_url = url
      @url = url
      @strategies = strategies || default_strategies
    end

    def call
      execute_url_strategies
      @url
    end

    private

    def execute_url_strategies
      @strategies.each do |strategy|
        @url = strategy.new.call(@url)
      end
    end

    def default_strategies
      [UrlProcessing::Strategies::Escape, UrlProcessing::Strategies::ProtocolPrepend]
    end
  end
end
