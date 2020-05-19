# frozen_string_literal: true

class LinkSerializer < BaseSerializer
  include Rails.application.routes.url_helpers

  attributes :id, :digest, :url, :attendances_count

  attribute :short_url do |link|
    Rails.application.routes.url_helpers.short_url(digest: link.digest)
  end

  attribute :attendances_count, &:attendances_count_value
  attribute :uniq_attendances_count, &:uniq_attendances_size

  attribute :country_stats do |link|
    link.country_stats_value.each_with_object({}) do |(country_id, attendances_count), accum|
      country = Country.fetch_by_id(Integer(country_id))
      accum[country.name] = { alpha: country.alpha_2_code, attendancesCount: attendances_count.to_i }
    end
  end
end
