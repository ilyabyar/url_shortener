# frozen_string_literal: true

module RedisCounter
  extend ActiveSupport::Concern

  included do
    counter :attendances_count
    set :uniq_attendances
    hash_key :country_stats

    after_commit :clear_attendance_redis_fields, on: :destroy
  end

  def save_to_redis(ip:, country:)
    increment_attendances
    add_to_attendances_set(ip)
    add_stats_by_country(country)
  end

  private

  def increment_attendances
    attendances_count.increment
  end

  def add_to_attendances_set(key)
    uniq_attendances.add key
  end

  def add_stats_by_country(country)
    country_stats.incr(country.id, 1)
  end

  def clear_attendance_redis_fields
    attendances_count.clear
    uniq_attendances.clear
    country_stats.clear
  end
end
