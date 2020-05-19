# frozen_string_literal: true

module RedisCounter
  extend ActiveSupport::Concern

  included do
    counter :attendances_count
    set :uniq_attendances
    hash_key :country_stats

    after_commit :clear_attendance_redis_fields, on: :destroy

    delegate :value, to: :attendances_count, prefix: true
    delegate :size, to: :uniq_attendances, prefix: true
    delegate :value, to: :country_stats, prefix: true
  end

  def save_to_redis(ip:, country_id:)
    increment_attendances
    add_to_attendances_set(ip)
    add_stats_by_country(country_id)
  end

  private

  def increment_attendances
    attendances_count.increment
  end

  def add_to_attendances_set(key)
    uniq_attendances.add key
  end

  def add_stats_by_country(country_id)
    country_stats.incr(country_id, 1)
  end

  def clear_attendance_redis_fields
    attendances_count.clear
    uniq_attendances.clear
    country_stats.clear
  end
end
