# frozen_string_literal: true

class Link < ApplicationRecord
  validates :url, presence: true
  validates :digest, uniqueness: true, presence: true

  def process!
    generate_digest!
    save!
  end

  private

  def generate_digest!
    self.digest = DigestGeneration::GeneratorService.new(url: url).call { self.class.exists?(url) }
  end
end
