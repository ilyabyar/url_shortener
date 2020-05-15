# frozen_string_literal: true

class LinkSerializer < BaseSerializer
  include Rails.application.routes.url_helpers

  attributes :id, :digest, :url

  attribute :short_url do |link|
    Rails.application.routes.url_helpers.short_url(digest: link.digest)
  end
end
