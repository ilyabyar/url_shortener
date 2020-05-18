# frozen_string_literal: true

class Link < ApplicationRecord
  include Redis::Objects
  include RedisCounter

  validates :url, presence: true
  validates :digest, uniqueness: true, presence: true

  has_many :attendances, dependent: :destroy

  class << self
    def fetch_data_by_digest(digest)
      Rails.cache.fetch("digest_#{digest}") do
        link = select(:id, :url).find_by!(digest: digest)
        link.short_attributes_hash
      end
    end

    def digest_exists?(str)
      exists?(digest: str)
    end
  end

  def short_attributes_hash
    { id: id, url: url }
  end

  def process!
    return if digest

    self.url = process_url
    self.digest = generate_digest
    save!
  end

  private

  def process_url
    UrlProcessing::Processor.new(url).call
  end

  def generate_digest
    DigestGeneration::Generator.new.call { |rand_string| self.class.digest_exists?(rand_string) }
  end
end
