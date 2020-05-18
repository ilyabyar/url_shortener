# frozen_string_literal: true

class LinkSerializer < BaseSerializer
  include Rails.application.routes.url_helpers

  attributes :id, :digest, :url, :attendances_count

  attribute :short_url do |link|
    Rails.application.routes.url_helpers.short_url(digest: link.digest)
  end

  attribute :attendances_count do |link|
    link.attendances_count.value
  end

  attribute :uniq_attendances_count do |link|
    link.uniq_attendances.length
  end
end
