# frozen_string_literal: true

module DigestGeneration
  class Generator
    MAX_NUM_OF_ATTEMPTS = 5
    MIN_LENGTH = 8
    MAX_LENGTH_VARIETY = 3

    def initialize
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
      @digest = SecureRandom.urlsafe_base64(MIN_LENGTH + rand(MAX_LENGTH_VARIETY))
    end

    def increment_attempts
      @num_of_attemps += 1
    end

    def limit_reached?
      @num_of_attemps == MAX_NUM_OF_ATTEMPTS
    end
  end
end
