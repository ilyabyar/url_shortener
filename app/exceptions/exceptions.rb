# frozen_string_literal: true

module Exceptions
  class BaseError < StandardError
  end

  class NotUniqueDigestError < BaseError; end
end
