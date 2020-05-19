# frozen_string_literal: true

class RedisStatsWorker
  include Sidekiq::Worker

  sidekiq_options queue: :redis_stats

  def perform(link_id, country_id, ip)
    # TODO: For idempotancy use raw redis and transactions(MULTI)
    Link.find(link_id).save_to_redis(ip: ip, country_id: country_id)
  end
end
