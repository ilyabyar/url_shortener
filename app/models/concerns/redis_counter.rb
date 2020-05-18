# frozen_string_literal: true

module RedisCounter
  extend ActiveSupport::Concern

  included do
    counter :attendances_count
    set :uniq_attendances

    after_commit :clear_attendance_redis_fields, on: :destroy
  end

  def save_to_redis(ip)
    increment_attendances
    add_to_attendances_set(ip)
  end

  private

  def increment_attendances
    attendances_count.increment
  end

  def add_to_attendances_set(key)
    uniq_attendances.add key
  end

  def clear_attendance_redis_fields
    attendances_count.clear
    uniq_attendances.clear
  end
end
