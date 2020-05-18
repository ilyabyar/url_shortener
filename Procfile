web: bin/rails server -p $PORT -e $RAILS_ENV
worker: MALLOC_ARENA_MAX=2 bundle exec sidekiq -e $RAILS_ENV -t 25 -C config/sidekiq.yml