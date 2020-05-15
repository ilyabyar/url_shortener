# frozen_string_literal: true

class Link < ApplicationRecord
  include Redis::Objects

  validates :url, presence: true
  validates :digest, uniqueness: true, presence: true

  has_many :attendances, dependent: :destroy

  counter :attendances_count_cache

  def process!
    return if digest

    prepend_protocol_if_needed if relative_url?
    generate_digest!
    save!
  end

  private

  # TODO: refactor
  def prepend_protocol_if_needed
    self.url = URI::HTTP.build(host: url)
  end

  def relative_url?
    URI.parse(url).relative?
  end

  def generate_digest!
    self.digest = DigestGeneration::GeneratorService.new(url: url).call { |rand_string| self.class.exists?(digest: rand_string) }
  end
end
