# frozen_string_literal: true

class Link < ApplicationRecord
  include Redis::Objects
  include RedisCounter

  validates :url, presence: true
  validates :digest, uniqueness: true, presence: true

  has_many :attendances, dependent: :destroy

  def self.fetch_data_by_digest(digest)
    Rails.cache.fetch("digest_#{digest}") do
      link = select(:id, :url).find_by!(digest: digest)
      { id: link.id, url: link.url }
    end
  end

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
