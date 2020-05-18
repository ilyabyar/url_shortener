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

  attribute :country_stats do |link|
    link.country_stats.value.each_with_object({}) do |(country_id, attendances_count), accum|
      name = Country.all_id_name.fetch(Integer(country_id))
      alpha = Carmen::Country.named(name).alpha_2_code
      accum[name] = { alpha: alpha, attendancesCount: attendances_count.to_i }
    end
  end
end
