#web: bundle exec unicorn config.ru -p $PORT -c ./unicorn.rb
web: bundle exec puma -t ${PUMA_MIN_THREADS:-8}:${PUMA_MAX_THREADS:-12} -w ${PUMA_WORKERS:-3} -p $PORT -e ${RACK_ENV:-development}

