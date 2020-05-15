# frozen_string_literal: true

module DigestGeneration
  class GeneratorService
    MAX_NUM_OF_ATTEMPTS = 5

    def initialize(url:)
      @url = url
      @num_of_attemps = 0
      @uniq = false
    end

    def call
      until @uniq
        generate_digest
        @uniq = !yield(@digest)
        increment_attempts
        raise Exceptions::NotUniqueDigestError if limit_reached?
      end
      @digest
    end

    private

    def generate_digest
      # TODO: move out hardcoded values
      @digest = SecureRandom.urlsafe_base64(8 + rand(@url.length % 3))
    end

    def increment_attempts
      @num_of_attemps += 1
    end

    def limit_reached?
      @num_of_attemps == MAX_NUM_OF_ATTEMPTS
    end
  end
end
